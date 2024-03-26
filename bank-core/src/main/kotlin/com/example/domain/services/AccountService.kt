package com.example.domain.services

import com.example.common.Constants
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
import com.example.domain.rabbitMq.RabbitMqPublisher
import com.example.domain.repositories.IAccountRepository
import com.example.domain.repositories.ITransactionRepository
import com.example.domain.utils.ExchangeRateProvider
import com.example.domain.utils.JsonUtil
import com.example.presentation.dto.UserInfoDto
import java.math.BigDecimal
import java.util.*

class AccountService(
    private val accountRepository: IAccountRepository,
) {
    fun openAccount(userId: String, createAccountDTO: CreateAccountDTO): Account {
        validateAccountData(createAccountDTO)

        val newAccount = Account(
            id = 0,
            userId = userId,
            accountNumber = generateAccountNumber(),
            balance = createAccountDTO.initialDeposit,
            currencyType = createAccountDTO.currencyType,
            accountType = createAccountDTO.accountType,
            accountStatus = AccountStatus.ACTIVE,
            interestRate = createAccountDTO.interestRate
        )

        return accountRepository.createAccount(newAccount)
    }

    fun closeAccount(accountId: Int) {
        val account = accountRepository.getAccountById(accountId)
            ?: throw AccountNotFoundException("Account with ID $accountId not found")

        accountRepository.closeAccount(accountId)
    }

    suspend fun deposit(accountId: Int, money: Money) {
        val account = accountRepository.getAccountById(accountId)
            ?: throw AccountNotFoundException("Account with ID $accountId not found")

        if (account.accountStatus == AccountStatus.CLOSED) {
            throw AccountClosedException(accountId)
        }


        val exchangeRate = ExchangeRateProvider.getExchangeRate(money.currencyType, account.currencyType)
        val convertedAmount = money.convertTo(account.currencyType, exchangeRate).amount

        val transaction = Transaction(
            id = 0, // временный ID
            amount = convertedAmount,
            fromAccountId = null,
            toAccountId = accountId,
            transactionType = TransactionType.DEPOSIT,
            currencyType = money.currencyType
        )

        val transactionJson = JsonUtil.serializeTransaction(transaction)
        RabbitMqPublisher.publishMessage(Constants.TRANSACTION_QUEUE, transactionJson)
    }

    suspend fun withdraw(accountId: Int, money: Money) {
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

        val transaction = Transaction(
            id = 0,
            amount = convertedAmount,
            fromAccountId = accountId,
            toAccountId = null,
            transactionType = TransactionType.WITHDRAWAL,
            currencyType = money.currencyType
        )

        val transactionJson = JsonUtil.serializeTransaction(transaction)
        RabbitMqPublisher.publishMessage("transactionQueue", transactionJson)
    }

    suspend fun transfer(fromAccountId: Int, toAccountId: Int, money: Money) {
        val fromAccount = accountRepository.getAccountById(fromAccountId)
            ?: throw AccountNotFoundException("From account not found")

        val toAccount = accountRepository.getAccountById(toAccountId)
            ?: throw AccountNotFoundException("To account not found")

        if (fromAccount.accountStatus == AccountStatus.CLOSED) {
            throw AccountClosedException(fromAccountId)
        }

        if (toAccount.accountStatus == AccountStatus.CLOSED) {
            throw AccountClosedException(toAccountId)
        }

        val exchangeRate = ExchangeRateProvider.getExchangeRate(money.currencyType, toAccount.currencyType)
        val convertedAmount = money.convertTo(money.currencyType, exchangeRate).amount

        if (fromAccount.balance < convertedAmount) {
            throw InsufficientFundsException("Insufficient funds in from account")
        }

        val transaction = Transaction(
            id = 0, // временный ID
            amount = convertedAmount,
            fromAccountId = fromAccountId,
            toAccountId = toAccountId,
            transactionType = TransactionType.TRANSFER,
            currencyType = money.currencyType
        )

        val transactionJson = JsonUtil.serializeTransaction(transaction)
        RabbitMqPublisher.publishMessage("transactionQueue", transactionJson)
    }

    fun getAccountById(accountId: Int): Account {
        return accountRepository.getAccountById(accountId)
            ?: throw AccountNotFoundException("Account with ID $accountId not found")
    }

    fun getAccountsByUserId(userId: String): List<Account> {
        return accountRepository.getAccountsByUserId(userId)
    }

    fun getAllUniqueUsersWithAccount ():  List<UserInfoDto> {
        return accountRepository.getAllUserIdsWithAccount()
    }

    fun getAllAccounts(): List<Account> {
        return accountRepository.getAllAccounts()
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