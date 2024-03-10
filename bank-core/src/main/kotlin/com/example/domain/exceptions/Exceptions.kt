package com.example.domain.exceptions

class CustomerExistsException(userId: String) :
    Exception("Customer with userId $userId already exists")

class CustomerNotFoundException(customerId: Int) :
    Exception("Customer with id $customerId not found")

class InvalidCustomerDataException(message: String) :
    Exception("Invalid customer data: $message")

class InvalidAccountDataException(message: String) : Exception(message)

class AccountNotFoundException(message: String) : Exception(message)

class InsufficientFundsException(message: String) : Exception(message)

class AccountClosedException(accountId: Int) :
    Exception("Account with ID $accountId is closed and cannot be used for transactions.")