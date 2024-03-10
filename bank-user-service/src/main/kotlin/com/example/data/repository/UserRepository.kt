package com.example.data.repository

import com.example.data.entities.AccountRequestStatus
import com.example.data.entities.UserRole
import com.example.data.entities.Users
import com.example.domain.models.User
import com.example.domain.repository.IUserRepository
import com.example.domain.utills.PasswordHasher
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.transactions.transaction


class UserRepository : IUserRepository {

    override fun registerUser(user: User): User = transaction {
        val userId = Users.insert {
            it[username] = user.username
            it[email] = user.email
            it[passwordHash] = PasswordHasher.hash(user.password)
            it[role] = user.role
            it[accountRequestStatus] = user.accountRequestStatus
        } get Users.id
        user.copy(id = userId.value)
    }

    override fun authenticate(email: String, password: String): User? = transaction {
        val user = Users.select { Users.email eq email }
            .mapNotNull { toUser(it) }
            .singleOrNull()

        if (user != null && PasswordHasher.verify(password, user.password)) {
            return@transaction user
        } else {
            return@transaction null
        }
    }

    override fun getUsersByStatus(status: AccountRequestStatus): List<User> = transaction {
        Users.select { Users.accountRequestStatus eq status }
            .map { toUser(it) }
    }

    override fun updateUserStatus(userId: Int, newStatus: AccountRequestStatus) = transaction {
        Users.update({ Users.id eq userId }) {
            it[accountRequestStatus] = newStatus
        } > 0
    }

    override fun getUserRoleById(userId: Int): UserRole? = transaction {
        Users.select { Users.id eq userId }
            .mapNotNull { it[Users.role] }
            .singleOrNull()
    }

    override fun existsById(userId: Int): Boolean = transaction {
        Users.select { Users.id eq userId }.count() > 0
    }

    override fun findById(userId: Int): User? = transaction {
        Users.select { Users.id eq userId }
            .mapNotNull { toUser(it) }
            .singleOrNull()
    }

    override fun findByEmail(email: String): User? = transaction {
        Users.select { Users.email eq email }
            .mapNotNull { toUser(it) }
            .singleOrNull()
    }

    private fun toUser(row: ResultRow): User =
        User(
            id = row[Users.id].value,
            username = row[Users.username],
            email = row[Users.email],
            password = row[Users.passwordHash],
            role = row[Users.role],
            accountRequestStatus = row[Users.accountRequestStatus]
        )
}