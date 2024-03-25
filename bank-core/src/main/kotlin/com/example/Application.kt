package com.example

import com.example.common.Constants
import com.example.data.entities.AccountType
import com.example.data.entities.CurrencyType
import com.example.domain.services.AccountService
import com.example.plugins.*
import com.example.presentation.configureRouting
import com.example.presentation.dto.CreateAccountDTO
import com.example.presentation.installExceptionHandling
import com.typesafe.config.ConfigFactory
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.cio.*
import io.ktor.server.config.*
import io.ktor.server.engine.*
import io.ktor.server.plugins.cors.routing.*
import org.koin.ktor.ext.inject
import java.math.BigDecimal

fun main() {
    embeddedServer(CIO, port = 8080, host = "0.0.0.0", module = Application::module)
        .start(wait = true)
}

fun Application.module() {
    val appConfig = HoconApplicationConfig(ConfigFactory.load())
    val accountService: AccountService by inject()

    installKoin()
    installExceptionHandling()
    installWebsockets()
    configureRouting()
    configureSerialization()
    initDatabase(appConfig)
    initializeBankAccount(accountService)
    install(CORS) {
        anyHost()
        allowHeader(HttpHeaders.ContentType)
    }
}

fun initializeBankAccount(accountService: AccountService) {
    val createAccountDTO = CreateAccountDTO(
        initialDeposit = BigDecimal(1000000000000000),
        currencyType = CurrencyType.USD,
        accountType = AccountType.SAVINGS_ACCOUNT,
        interestRate = 0.02f
    )

    // Создаем аккаунт банка
    accountService.openAccount(Constants.BANK_ID, createAccountDTO)
}

