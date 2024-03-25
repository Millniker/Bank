package com.example.di

import com.example.data.repositories.AccountRepository
import com.example.data.repositories.TransactionRepository
import com.example.domain.rabbitMq.RabbitMqConsumer
import com.example.domain.rabbitMq.RabbitMqPublisher
import com.example.domain.repositories.IAccountRepository
import com.example.domain.repositories.ITransactionRepository
import com.example.domain.services.AccountService
import com.example.domain.services.TransactionService
import com.rabbitmq.client.Connection
import com.rabbitmq.client.ConnectionFactory
import org.koin.core.scope.get
import org.koin.dsl.module


val appModule = module {
    single<IAccountRepository> { AccountRepository() }
    single<ITransactionRepository> { TransactionRepository() }
    single { AccountService(get()) }
    single { TransactionService(get(), get()) }
}