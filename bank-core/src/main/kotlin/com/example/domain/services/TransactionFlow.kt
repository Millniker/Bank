package com.example.domain.services

import com.example.domain.models.Transaction
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.filter

object TransactionFlow {
    private val _transactionFlow = MutableSharedFlow<Transaction>()

    fun getTransactionsFlowForAccount(accountId: Int) = _transactionFlow.asSharedFlow()
        .filter { it.fromAccountId == accountId || it.toAccountId == accountId }

    suspend fun emit(transaction: Transaction) {
        _transactionFlow.emit(transaction)
    }
}