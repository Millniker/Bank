package com.example.domain.services

import com.example.data.entities.AccountStatus
import com.example.data.entities.TransactionType
import com.example.domain.exceptions.AccountClosedException
import com.example.domain.exceptions.AccountNotFoundException
import com.example.domain.exceptions.InsufficientFundsException
import com.example.domain.exceptions.InvalidAccountDataException
import com.example.domain.models.Account
import com.example.domain.models.Transaction
import com.example.presentation.dto.CreateAccountDTO
import com.example.domain.models.Money
import com.example.domain.repositories.IAccountRepository
import com.example.domain.repositories.ITransactionRepository
import com.example.domain.utils.ExchangeRateProvider
import java.math.BigDecimal
import java.util.*

class AccountService(
    private val accountRepository: IAccountRepository,
    private val transactionRepository: ITransactionRepository
) {
    fun openAccount(customerId: Int, createAccountDTO: CreateAccountDTO): Account {
        validateAccountData(createAccountDTO)

        val newAccount = Account(
            id = 0,
            customerId = customerId,
            accountNumber = generateAccountNumber(),
            balance = createAccountDTO.initialDeposit,
            currencyType = createAccountDTO.currencyType,
            accountType = createAccountDTO.accountType,
            accountStatus = AccountStatus.ACTIVE,
            interestRate = createAccountDTO.interestRate
        )

        return accountRepository.createAccount(newAccount, customerId)
    }

    fun closeAccount(accountId: Int) {
        val account = accountRepository.getAccountById(accountId)
            ?:  throw AccountNotFoundException("Account with ID $accountId not found")

        accountRepository.closeAccount(accountId)
    }

    fun deposit(accountId: Int, money: Money) {
        val account = accountRepository.getAccountById(accountId)
            ?: throw AccountNotFoundException("Account with ID $accountId not found")

        if (account.accountStatus == AccountStatus.CLOSED) {
            throw AccountClosedException(accountId)
        }

        val exchangeRate = ExchangeRateProvider.getExchangeRate(money.currencyType, account.currencyType)
        val convertedAmount = money.convertTo(account.currencyType, exchangeRate).amount

        accountRepository.updateBalance(accountId, account.balance.add(convertedAmount))

        transactionRepository.createTransaction(Transaction(
            id = 0,
            amount = convertedAmount,
            fromAccountId = null,
            toAccountId = accountId,
            transactionType = TransactionType.DEPOSIT,
        ))
    }

    fun withdraw(accountId: Int, money: Money) {
        val account = accountRepository.getAccountById(accountId)
            ?: throw AccountNotFoundException("Account with ID $accountId not found")


        if (account.accountStatus == AccountStatus.CLOSED) {
            throw AccountClosedException(accountId)
        }

        val exchangeRate = ExchangeRateProvider.getExchangeRate(money.currencyType, account.currencyType)
        val convertedAmount = money.convertTo(account.currencyType, exchangeRate).amount

        if (account.balance < convertedAmount) {
            throw InsufficientFundsException("Insufficient funds for withdrawal")
        }

        accountRepository.updateBalance(accountId, account.balance.subtract(convertedAmount))

        transactionRepository.createTransaction(Transaction(
            id = 0,
            amount = convertedAmount,
            fromAccountId = accountId,
            toAccountId = null,
            transactionType = TransactionType.WITHDRAWAL,
        ))
    }

    fun getAccountById(accountId: Int): Account? {
        return accountRepository.getAccountById(accountId)
    }

    private fun validateAccountData(createAccountDto: CreateAccountDTO) {
        if (createAccountDto.initialDeposit < BigDecimal.ZERO) {
            throw InvalidAccountDataException("Initial deposit cannot be negative")
        }
        if (createAccountDto.interestRate < 0) {
            throw InvalidAccountDataException("Interest rate cannot be negative")
        }
    }

    private fun generateAccountNumber(): String {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 10)
    }
}