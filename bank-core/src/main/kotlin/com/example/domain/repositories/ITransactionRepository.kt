package com.example.domain.repositories

import com.example.domain.models.Transaction

interface ITransactionRepository {
    fun createTransaction(newTransaction: Transaction): Transaction
    fun getTransactionById(id: Int): Transaction?
    fun getTransactionsForAccount(accountId: Int): List<Transaction>
}