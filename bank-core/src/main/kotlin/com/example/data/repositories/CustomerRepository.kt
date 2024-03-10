package com.example.data.repositories

import com.example.data.entities.Customers
import com.example.domain.utils.localDateToSeconds
import com.example.domain.models.Customer
import com.example.domain.repositories.ICustomerRepository
import com.example.domain.utils.secondsToLocalDate
import org.jetbrains.exposed.sql.ResultRow
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.select
import org.jetbrains.exposed.sql.selectAll
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.LocalDateTime
import java.time.ZoneOffset

class CustomerRepository: ICustomerRepository {
    override fun createCustomer(newCustomer: Customer): Customer = transaction {
        val customerId = Customers.insert {
            it[fullName] = newCustomer.fullName
            it[dateOfBirth] = newCustomer.dateOfBirth
            it[passportDetails] = newCustomer.passportDetails
            it[registrationDate] = LocalDateTime.now()
            it[userId] = newCustomer.userId
        } get Customers.id

        getCustomerById(customerId.value)!!
    }

    override fun getCustomerByUserId(userId: String): Customer? = transaction {
        Customers.select { Customers.userId eq userId }
            .mapNotNull { toCustomer(it) }
            .singleOrNull()
    }

    override fun getCustomerById(id: Int): Customer? = transaction {
        Customers.select { Customers.id eq id }
            .mapNotNull { toCustomer(it) }
            .singleOrNull()
    }
    override fun getAllCustomers(): List<Customer> = transaction {

        Customers.selectAll()
            .map { toCustomer(it) }
    }

    private fun toCustomer(row: ResultRow): Customer =
        Customer(
            id = row[Customers.id].value,
            fullName = row[Customers.fullName],
            dateOfBirth = row[Customers.dateOfBirth],
            passportDetails = row[Customers.passportDetails],
            registrationDate = row[Customers.registrationDate],
            userId = row[Customers.userId]
        )
}