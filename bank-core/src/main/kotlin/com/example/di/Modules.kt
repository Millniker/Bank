package com.example.di

import com.example.data.repositories.AccountRepository
import com.example.data.repositories.CustomerRepository
import com.example.data.repositories.TransactionRepository
import com.example.domain.repositories.IAccountRepository
import com.example.domain.repositories.ICustomerRepository
import com.example.domain.repositories.ITransactionRepository
import com.example.domain.services.AccountService
import com.example.domain.services.CustomerService
import com.example.domain.services.TransactionService
import org.koin.dsl.module


val appModule = module {
    single<ICustomerRepository> {CustomerRepository()}
    single<IAccountRepository> {AccountRepository()}
    single<ITransactionRepository> {TransactionRepository()}
    single { AccountService(get(), get()) }
    single { CustomerService(get(), get()) }
    single { TransactionService(get()) }
}