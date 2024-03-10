package com.example.domain.services

import com.example.domain.models.Transaction
import com.example.domain.repositories.ITransactionRepository

class TransactionService(
    private val transactionRepository: ITransactionRepository
) {
    fun getAccountTransactions(accountId: Int): List<Transaction> {
        return transactionRepository.getTransactionsForAccount(accountId)
    }
}