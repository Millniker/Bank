package com.example.domain.repositories

import com.example.domain.models.Customer

interface ICustomerRepository {
    fun createCustomer(newCustomer: Customer): Customer
    fun getCustomerByUserId(userId: String): Customer?
    fun getCustomerById(id: Int): Customer?
    fun getAllCustomers(): List<Customer>
}