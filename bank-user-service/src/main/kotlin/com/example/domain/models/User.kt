package com.example.domain.models

import com.example.data.entities.AccountRequestStatus
import com.example.data.entities.UserRole
import kotlinx.serialization.Serializable

@Serializable
data class User(
    val id: Int,
    val username: String,
    val email: String,
    val password: String,
    val role: UserRole,
    val accountRequestStatus: AccountRequestStatus?
)