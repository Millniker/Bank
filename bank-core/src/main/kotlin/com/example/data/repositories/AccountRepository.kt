package com.example.data.repositories

import com.example.data.entities.AccountStatus
import com.example.data.entities.Accounts
import com.example.domain.models.Account
import com.example.domain.repositories.IAccountRepository
import com.example.domain.utils.secondsToLocalDateTime
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.transactions.transaction
import java.math.BigDecimal
import java.time.ZoneOffset

class AccountRepository : IAccountRepository {

    override fun getAccountById(id: Int): Account? = transaction {
        Accounts.select { Accounts.id eq id }
            .mapNotNull { toAccount(it) }
            .singleOrNull()
    }

    override fun createAccount(newAccount: Account, customerId: Int): Account = transaction {
        val insertedId = Accounts.insert {
            it[accountNumber] = newAccount.accountNumber
            it[balance] = newAccount.balance
            it[customer] = customerId
            it[currencyType] = newAccount.currencyType
            it[accountType] = newAccount.accountType
            it[accountStatus] = newAccount.accountStatus
            it[openingDate] = newAccount.openingDate
            it[interestRate] = newAccount.interestRate
        } get Accounts.id

        getAccountById(insertedId.value)!!
    }

    override fun closeAccount(accountId: Int): Unit = transaction {
        Accounts.update({ Accounts.id eq accountId }) {
            it[accountStatus] = AccountStatus.CLOSED
        }
    }

    override fun deposit(accountId: Int, amount: BigDecimal): Unit = transaction {
        Accounts.update({ Accounts.id eq accountId }) {
            with(SqlExpressionBuilder) {
                it.update(balance, balance + amount)
            }
        }
    }

    override fun withdraw(accountId: Int, amount: BigDecimal): Unit = transaction {
        Accounts.update({ Accounts.id eq accountId }) {
            with(SqlExpressionBuilder) {
                it.update(balance, balance - amount)
            }
        }
    }

    override fun updateBalance(accountId: Int, newBalance: BigDecimal): Unit = transaction {
        Accounts.update({ Accounts.id eq accountId }) {
            it[balance] = newBalance
        }
    }

    override fun getAllAccounts(): List<Account> = transaction {
        Accounts.selectAll().map { toAccount(it) }
    }

    override fun getAccountsByCustomerId(customerId: Int): List<Account> = transaction {
        Accounts.select { Accounts.customer eq customerId }
            .map { toAccount(it) }
    }

    private fun toAccount(row: ResultRow): Account =
        Account(
            id = row[Accounts.id].value,
            accountNumber = row[Accounts.accountNumber],
            balance = row[Accounts.balance],
            currencyType = row[Accounts.currencyType],
            accountType = row[Accounts.accountType],
            accountStatus = row[Accounts.accountStatus],
            openingDate = row[Accounts.openingDate],
            interestRate = row[Accounts.interestRate],
            customerId = row[Accounts.customer].value
        )
}
