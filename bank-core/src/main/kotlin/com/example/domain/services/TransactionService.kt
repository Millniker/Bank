package com.example.domain.services

import com.example.common.Constants
import com.example.common.applicationScope
import com.example.data.entities.TransactionType
import com.example.domain.exceptions.AccountNotFoundException
import com.example.domain.exceptions.InsufficientFundsException
import com.example.domain.models.Transaction
import com.example.domain.rabbitMq.RabbitMqConsumer
import com.example.domain.repositories.IAccountRepository
import com.example.domain.repositories.ITransactionRepository
import com.example.domain.utils.JsonUtil
import kotlinx.coroutines.launch
import org.jetbrains.exposed.sql.transactions.transaction
import java.math.BigDecimal

class TransactionService(
    private val transactionRepository: ITransactionRepository,
    private val accountRepository: IAccountRepository,
    private val rabbitMqConsumer: RabbitMqConsumer,
) {

    init {
        rabbitMqConsumer.consumeMessages(Constants.TRANSACTION_QUEUE) { message ->
            handleTransactionMessage(message)
        }
    }

    private fun handleTransactionMessage(message: String) {
        val transactionInfo = JsonUtil.deserializeTransaction(message)
        processTransaction(transactionInfo)
    }

    private fun processTransaction(transactionInfo: Transaction) {
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

    private fun handleTransfer(transactionInfo: Transaction) {
        transaction {
            val fromAccount = accountRepository.getAccountById(transactionInfo.fromAccountId!!)
                ?: throw AccountNotFoundException("Account with ID ${transactionInfo.toAccountId} not found")
            val toAccount = accountRepository.getAccountById(transactionInfo.toAccountId!!)
                ?: throw AccountNotFoundException("Account with ID ${transactionInfo.toAccountId} not found")

            val newBalanceFrom = fromAccount.balance.subtract(transactionInfo.amount)
            if (newBalanceFrom < BigDecimal.ZERO) {
                throw InsufficientFundsException("Insufficient funds for transfer")
            }

            val newBalanceTo = toAccount.balance.add(transactionInfo.amount)

            accountRepository.updateBalance(transactionInfo.fromAccountId, newBalanceFrom)
            accountRepository.updateBalance(transactionInfo.toAccountId, newBalanceTo)

            transactionRepository.createTransaction(
                transactionInfo
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