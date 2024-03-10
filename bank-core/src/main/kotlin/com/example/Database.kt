package com.example

import com.example.data.entities.Accounts
import com.example.data.entities.Customers
import com.example.data.entities.Transactions
import io.ktor.server.application.*
import io.ktor.server.config.*
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.transaction

fun Application.initDatabase(appConfig: HoconApplicationConfig) {
    val url = appConfig.property("ktor.database.url").getString()
    val driver = appConfig.property("ktor.database.driver").getString()
    val user = appConfig.property("ktor.database.user").getString()
    val password = appConfig.property("ktor.database.password").getString()

    Database.connect(url, driver, user, password)

    transaction {
        SchemaUtils.create(Customers, Accounts, Transactions)
    }
}