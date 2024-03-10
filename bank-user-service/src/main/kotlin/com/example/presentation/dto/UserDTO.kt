package com.example.presentation.dto

import com.example.data.entities.AccountRequestStatus
import com.example.data.entities.UserRole
import com.example.domain.models.User
import kotlinx.serialization.Serializable

@Serializable
data class UserDTO(
    val username: String,
    val email: String,
    val password: String,
    val role: UserRole,
)

fun mapToUserModel(userDTO: UserDTO): User {
    return User(
        id = 0,
        email = userDTO.email,
        password = userDTO.password,
        username = userDTO.username,
        role = userDTO.role,
        accountRequestStatus = AccountRequestStatus.PENDING
    )
}