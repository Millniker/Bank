package com.example.di

import com.example.data.repository.UserRepository
import com.example.domain.UserService
import com.example.domain.repository.IUserRepository
import org.koin.dsl.module

val appModule = module {
    single<IUserRepository> {UserRepository()}
    single { UserService(get()) }
}