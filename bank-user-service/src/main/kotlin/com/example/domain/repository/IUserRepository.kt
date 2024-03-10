package com.example.domain.repository

import com.example.data.entities.AccountRequestStatus
import com.example.data.entities.UserRole
import com.example.domain.models.User

interface IUserRepository {
    fun registerUser(user: User): User
    fun authenticate(email: String, password: String): User?
    fun getUsersByStatus(status: AccountRequestStatus): List<User>
    fun updateUserStatus(userId: Int, newStatus: AccountRequestStatus): Boolean
    fun getUserRoleById(userId: Int): UserRole?
    fun existsById(userId: Int): Boolean
    fun findById(userId: Int): User?
    fun findByEmail(email: String): User?
}