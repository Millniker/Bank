package com.example

import com.example.data.initDatabase
import com.example.plugins.*
import com.example.presentation.configureRouting
import com.example.presentation.installExceptionHandling
import com.typesafe.config.ConfigFactory
import io.ktor.server.application.*
import io.ktor.server.cio.*
import io.ktor.server.config.*
import io.ktor.server.engine.*

fun main() {
    embeddedServer(CIO, port = 8081, host = "0.0.0.0", module = Application::module)
        .start(wait = true)
}

fun Application.module() {
    val appConfig = HoconApplicationConfig(ConfigFactory.load())
    configureSerialization()
    configureRouting()
    installKoin()
    installExceptionHandling()
    initDatabase(appConfig)
}
