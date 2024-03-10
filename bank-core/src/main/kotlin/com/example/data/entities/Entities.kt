package com.example.data.entities

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.CurrentDateTime
import org.jetbrains.exposed.sql.javatime.date
import org.jetbrains.exposed.sql.javatime.datetime

object Accounts : IntIdTable() {
    val accountNumber = varchar("account_number", length = 255)
    val customer = reference("customer_id", Customers)
    val balance = decimal("balance", precision = 10, scale = 2)
    val currencyType = enumerationByName("currency_type", 10, CurrencyType::class)
    val accountType = enumerationByName("account_type", 30, AccountType::class)
    val accountStatus = enumerationByName("account_status", 10, AccountStatus::class)
    val openingDate = datetime("opening_date").defaultExpression(CurrentDateTime)
    val interestRate = float("interest_rate")
}

object Transactions : IntIdTable() {
    val amount = decimal("amount", precision = 10, scale = 2)
    val fromAccount = reference("from_account_id", Accounts).nullable()
    val toAccount = reference("to_account_id", Accounts).nullable()
    val transactionType = enumerationByName("transaction_type", 20, TransactionType::class)
    val transactionDate = datetime("transaction_date").defaultExpression(CurrentDateTime)
}

object Customers : IntIdTable() {
    val fullName = varchar("full_name", length = 255)
    val dateOfBirth = date("date_of_birth")
    val passportDetails = varchar("passport_details", length = 255)
    val registrationDate = datetime("registration_date").defaultExpression(CurrentDateTime)
    val userId = varchar("user_id", length = 36)
}

enum class TransactionType {
    DEPOSIT, WITHDRAWAL, TRANSFER, LOAN_REPAYMENT
}

enum class CurrencyType {
    USD, EUR, RUB
}

enum class AccountStatus {
    ACTIVE, FROZEN, CLOSED
}

enum class AccountType {
    CURRENT_ACCOUNT, SAVINGS_ACCOUNT, FOREIGN_CURRENCY_ACCOUNT, LOAN_TYPE
}


