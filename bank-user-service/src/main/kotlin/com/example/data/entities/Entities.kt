package com.example.data.entities

import org.jetbrains.exposed.dao.id.IntIdTable


object Users : IntIdTable() {
    val username = varchar("username", length = 50).uniqueIndex()
    val email = varchar("email", length = 100).uniqueIndex()
    val passwordHash = varchar("password_hash", length = 64)
    val role = enumeration("role", UserRole::class)
    val accountRequestStatus = enumeration("account_request_status", AccountRequestStatus::class).nullable()
}

enum class UserRole {
    CLIENT, EMPLOYEE
}

enum class AccountRequestStatus {
    PENDING, APPROVED, REJECTED
}
