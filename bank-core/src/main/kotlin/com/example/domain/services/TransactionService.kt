package com.example.domain.services

import com.example.common.Constants
import com.example.common.applicationScope
import com.example.data.entities.TransactionType
import com.example.domain.exceptions.AccountNotFoundException
import com.example.domain.exceptions.InsufficientFundsException
import com.example.domain.models.Money
import com.example.domain.models.Transaction
import com.example.domain.rabbitMq.RabbitMqConsumer
import com.example.domain.repositories.IAccountRepository
import com.example.domain.repositories.ITransactionRepository
import com.example.domain.utils.ExchangeRateProvider
import com.example.domain.utils.JsonUtil
import kotlinx.coroutines.launch
import org.jetbrains.exposed.sql.transactions.transaction
import java.math.BigDecimal

class TransactionService(
    private val transactionRepository: ITransactionRepository,
    private val accountRepository: IAccountRepository,
) {

    init {
        RabbitMqConsumer.consumeMessages(Constants.TRANSACTION_QUEUE) { message ->
            handleTransactionMessage(message)
        }
    }

    private suspend fun handleTransactionMessage(message: String) {
        val transactionInfo = JsonUtil.deserializeTransaction(message)
        processTransaction(transactionInfo)
    }

    private suspend fun processTransaction(transactionInfo: Transaction) {
        when (transactionInfo.transactionType) {
            TransactionType.DEPOSIT -> handleDeposit(transactionInfo)
            TransactionType.WITHDRAWAL -> handleWithdrawal(transactionInfo)
            TransactionType.TRANSFER -> handleTransfer(transactionInfo)
            TransactionType.LOAN_REPAYMENT -> TODO()
        }
    }

    private fun handleDeposit(transactionInfo: Transaction) {
        transaction {
            val account = accountRepository.getAccountById(transactionInfo.toAccountId!!)
                ?: throw AccountNotFoundException("Account with ID ${transactionInfo.toAccountId} not found")
            val newBalance = account.balance.add(transactionInfo.amount)
            accountRepository.updateBalance(transactionInfo.toAccountId, newBalance)
            transactionRepository.createTransaction(
                transactionInfo
            )
            applicationScope.launch {
                TransactionFlow.emit(transactionInfo)
            }
        }
    }

    private fun handleWithdrawal(transactionInfo: Transaction) {
        transaction {
            val account = accountRepository.getAccountById(transactionInfo.fromAccountId!!)
                ?: throw AccountNotFoundException("Account with ID ${transactionInfo.fromAccountId} not found")
            val newBalance = account.balance.subtract(transactionInfo.amount)
            if (newBalance < BigDecimal.ZERO) {
                throw InsufficientFundsException("Insufficient funds for withdrawal")
            }
            accountRepository.updateBalance(transactionInfo.fromAccountId, newBalance)
            transactionRepository.createTransaction(
                transactionInfo
            )
            applicationScope.launch {
                TransactionFlow.emit(transactionInfo)
            }
        }
    }

    private suspend fun handleTransfer(transactionInfo: Transaction) {
            val fromAccount = accountRepository.getAccountById(transactionInfo.fromAccountId!!)
                ?: throw AccountNotFoundException("Account with ID ${transactionInfo.fromAccountId} not found")
            val toAccount = accountRepository.getAccountById(transactionInfo.toAccountId!!)
                ?: throw AccountNotFoundException("Account with ID ${transactionInfo.toAccountId} not found")

            val moneyFrom = Money(transactionInfo.amount, fromAccount.currencyType)

            val exchangeRateTo =
                ExchangeRateProvider.getExchangeRate(fromAccount.currencyType, toAccount.currencyType)
            val convertedMoneyTo = moneyFrom.convertTo(toAccount.currencyType, exchangeRateTo)

            if (fromAccount.balance < convertedMoneyTo.amount) {
                throw InsufficientFundsException("Insufficient funds for transfer")
            }

            val newBalanceFrom = fromAccount.balance.subtract(convertedMoneyTo.amount)
            val newBalanceTo = toAccount.balance.add(convertedMoneyTo.amount)

        transaction {
            accountRepository.updateBalance(transactionInfo.fromAccountId, newBalanceFrom)
            accountRepository.updateBalance(transactionInfo.toAccountId, newBalanceTo)

            // Создание транзакции с обновленными данными
            transactionRepository.createTransaction(
                Transaction(
                    id = 0, // временный ID
                    amount = convertedMoneyTo.amount,
                    currencyType = toAccount.currencyType,
                    fromAccountId = transactionInfo.fromAccountId,
                    toAccountId = transactionInfo.toAccountId,
                    transactionType = TransactionType.TRANSFER,
                )
            )
            applicationScope.launch {
                TransactionFlow.emit(transactionInfo)
            }
        }
    }

    fun getAccountTransactions(accountId: Int): List<Transaction> {
        return transactionRepository.getTransactionsForAccount(accountId)
    }
}