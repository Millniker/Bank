package com.example.domain.services

import com.example.domain.utils.secondsToLocalDate
import com.example.domain.exceptions.AccountNotFoundException
import com.example.domain.exceptions.CustomerExistsException
import com.example.domain.exceptions.CustomerNotFoundException
import com.example.domain.exceptions.InvalidCustomerDataException
import com.example.domain.models.Account
import com.example.domain.models.Customer
import com.example.domain.repositories.IAccountRepository
import com.example.domain.repositories.ICustomerRepository
import java.time.LocalDate
import java.time.Period

class CustomerService(
    private val customerRepository: ICustomerRepository,
    private val accountRepository: IAccountRepository
) {
    fun createCustomer(newCustomerData: Customer): Customer {
        val existingCustomer = customerRepository.getCustomerByUserId(newCustomerData.userId)
        if (existingCustomer != null) {
            throw CustomerExistsException(newCustomerData.userId)
        }

        validateNewCustomerData(newCustomerData)

        return customerRepository.createCustomer(newCustomerData)
    }

    fun getCustomerAccounts(customerId: Int): List<Account> {
        val customer = customerRepository.getCustomerById(customerId)
            ?: throw CustomerNotFoundException(customerId)

        return accountRepository.getAccountsByCustomerId(customer.id)
    }

    fun getCustomerByUserId(userId: String): Customer {
        return customerRepository.getCustomerByUserId(userId) ?: throw CustomerNotFoundException(userId.toInt())
    }

    fun getCustomerByAccountId(accountId: Int): Customer {
        val account = accountRepository.getAccountById(accountId)
            ?: throw AccountNotFoundException("Account with ID $accountId not found")

        return getCustomerById(account.customerId)
    }

    fun getCustomerById(id: Int): Customer {
        return customerRepository.getCustomerById(id) ?: throw CustomerNotFoundException(id)
    }

    fun getAllCustomers(): List<Customer> {
        return customerRepository.getAllCustomers()
    }

    fun getAllAccounts(): List<Account> {
        return accountRepository.getAllAccounts()
    }

    private fun validateNewCustomerData(newCustomerData: Customer) {
        if (newCustomerData.fullName.isBlank()) {
            throw InvalidCustomerDataException("Full name is required")
        }

        if (!isValidDateOfBirth(newCustomerData.dateOfBirth)) {
            throw InvalidCustomerDataException("Invalid date of birth")
        }

        if (newCustomerData.passportDetails.isBlank()) {
            throw InvalidCustomerDataException("Passport details are required")
        }

        if (newCustomerData.userId.isBlank()) {
            throw InvalidCustomerDataException("User ID is required")
        }
    }

    private fun isValidDateOfBirth(dateOfBirth: LocalDate): Boolean {
        val today = LocalDate.now()
        val p = Period.between(dateOfBirth, today)
        return p.years >= 18
    }
}