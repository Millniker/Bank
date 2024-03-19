package com.example.data.repositories

import com.example.data.entities.AccountStatus
import com.example.data.entities.Accounts
import com.example.domain.models.Account
import com.example.domain.repositories.IAccountRepository
import com.example.presentation.dto.UserInfoDto
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.transactions.transaction
import java.math.BigDecimal

class AccountRepository : IAccountRepository {

    override fun getAccountById(id: Int): Account? = transaction {
        Accounts.select { Accounts.id eq id }
            .mapNotNull { toAccount(it) }
            .singleOrNull()
    }

    override fun createAccount(newAccount: Account): Account = transaction {
        val insertedId = Accounts.insert {
            it[accountNumber] = newAccount.accountNumber
            it[balance] = newAccount.balance
            it[userId] = newAccount.userId
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

    override fun getAllUserIdsWithAccount(): List<UserInfoDto> = transaction {
        Accounts.slice(Accounts.userId)
            .selectAll()
            .map { it[Accounts.userId] }
            .distinct()
            .map { UserInfoDto(it) }
    }

    override fun getAccountsByUserId(userId: String): List<Account> = transaction {
        Accounts.select { Accounts.userId eq userId }
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
            userId = row[Accounts.userId]
        )
}
