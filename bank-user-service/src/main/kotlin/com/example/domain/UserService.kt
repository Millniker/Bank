package com.example.domain

import com.example.data.entities.AccountRequestStatus
import com.example.data.entities.UserRole
import com.example.domain.exeptions.*
import com.example.domain.models.User
import com.example.domain.repository.IUserRepository
import com.example.domain.utills.JwtConfig
import com.example.domain.utills.PasswordHasher

class UserService(private val userRepository: IUserRepository) {
    fun registerUser(user: User): User {
        validateUserData(user)
        if (!isEmailUnique(user.email)) {
            throw EmailAlreadyExistsException("Email ${user.email} is already in use")
        }
        return userRepository.registerUser(user)
    }

    fun authenticate(email: String, password: String): String {
        val user = userRepository.authenticate(email, password)
            ?: throw InvalidLoginCredentialsException("Invalid credentials provided.")

        return when (user.accountRequestStatus) {
            AccountRequestStatus.PENDING -> throw UserNotApprovedException("User account is pending approval.")
            AccountRequestStatus.REJECTED -> throw UserRejectedException("User account is rejected.")
            AccountRequestStatus.APPROVED -> JwtConfig.generateToken(user.id.toString())
            null -> throw UserNotFoundException("User not found.")
        }
    }

    fun getUsersByStatus(status: AccountRequestStatus): List<User> {
        return userRepository.getUsersByStatus(status)
    }

    fun updateUserStatus(token: String, userId: Int, newStatus: AccountRequestStatus) {
        val jwtUserId = JwtConfig.verifyToken(token) ?: throw UnauthorizedAccessException("Invalid token.")
        val userRole = userRepository.getUserRoleById(jwtUserId.toInt()) ?: throw UserNotFoundException("User not found.")

        if (userRole != UserRole.EMPLOYEE) {
            throw UnauthorizedAccessException("Access denied.")
        }

        userRepository.updateUserStatus(userId, newStatus)
    }

    fun userExists(userId: Int): Boolean {
        return userRepository.existsById(userId)
    }

    fun getUserById(token: String, userId: Int): User {
        val jwtUserId = JwtConfig.verifyToken(token) ?: throw UnauthorizedAccessException("Invalid token.")
        val userRole = userRepository.getUserRoleById(jwtUserId.toInt()) ?: throw UserNotFoundException("User not found.")

        if (userRole != UserRole.EMPLOYEE) {
            throw UnauthorizedAccessException("Access denied.")
        }
        return userRepository.findById(userId) ?: throw UserNotFoundException("User with id $userId not found.")
    }


    private fun validateUserData(user: User) {
        if (user.username.isBlank()) {
            throw InvalidUserDataException("Username cannot be empty.")
        }

        if (user.email.isBlank() || !isValidEmail(user.email)) {
            throw InvalidUserDataException("Invalid email format.")
        }

        if (user.password.length < 6) {
            throw InvalidUserDataException("Password is too short.")
        }

    }

    private fun isValidEmail(email: String): Boolean {
        return email.contains("@") && email.contains(".")
    }

    private fun isEmailUnique(email: String): Boolean {
        return userRepository.findByEmail(email) == null
    }
}