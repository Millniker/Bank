package com.example.domain.repositories

import com.example.domain.models.Account
import com.example.presentation.dto.UserInfoDto
import java.math.BigDecimal

interface IAccountRepository {
    fun getAccountById(id: Int): Account?
    fun createAccount(newAccount: Account): Account
    fun closeAccount(accountId: Int)
    fun deposit(accountId: Int, amount: BigDecimal)
    fun withdraw(accountId: Int, amount: BigDecimal)
    fun updateBalance(accountId: Int, newBalance: BigDecimal)
    fun getAccountsByUserId(userId: String): List<Account>
    fun getAllAccounts(): List<Account>

    fun getAllUserIdsWithAccount(): List<UserInfoDto>
}