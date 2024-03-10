package com.example.data.repositories

import com.example.data.entities.Transactions
import com.example.domain.models.Transaction
import com.example.domain.repositories.ITransactionRepository
import com.example.domain.utils.secondsToLocalDateTime
import org.jetbrains.exposed.sql.ResultRow
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.or
import org.jetbrains.exposed.sql.select
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.ZoneOffset

class TransactionRepository: ITransactionRepository {

    override fun createTransaction(newTransaction: Transaction): Transaction = transaction {
        val transactionId = Transactions.insert {
            it[amount] = newTransaction.amount
            it[fromAccount] = newTransaction.fromAccountId
            it[toAccount] = newTransaction.toAccountId
            it[transactionType] = newTransaction.transactionType
            it[transactionDate] = newTransaction.transactionDate
        } get Transactions.id

        getTransactionById(transactionId.value)!!
    }

    override fun getTransactionById(id: Int): Transaction? {
        return Transactions.select { Transactions.id eq id }
            .mapNotNull { toTransaction(it) }
            .singleOrNull()
    }

    override fun getTransactionsForAccount(accountId: Int): List<Transaction> = transaction {
        Transactions.select { Transactions.fromAccount eq accountId or (Transactions.toAccount eq accountId) }
            .map { toTransaction(it) }
    }

    private fun toTransaction(row: ResultRow): Transaction =
        Transaction(
            id = row[Transactions.id].value,
            amount = row[Transactions.amount],
            fromAccountId = row[Transactions.fromAccount]?.value,
            toAccountId = row[Transactions.toAccount]?.value,
            transactionType = row[Transactions.transactionType],
            transactionDate = row[Transactions.transactionDate]
        )
}