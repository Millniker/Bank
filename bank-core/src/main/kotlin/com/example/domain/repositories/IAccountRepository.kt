package com.example.domain.repositories

import com.example.domain.models.Account
import java.math.BigDecimal

interface IAccountRepository {
    fun getAccountById(id: Int): Account?
    fun createAccount(newAccount: Account, customerId: Int): Account
    fun closeAccount(accountId: Int)
    fun deposit(accountId: Int, amount: BigDecimal)
    fun withdraw(accountId: Int, amount: BigDecimal)
    fun updateBalance(accountId: Int, newBalance: BigDecimal)
    fun getAccountsByCustomerId(customerId: Int): List<Account>
    fun getAllAccounts(): List<Account>
}