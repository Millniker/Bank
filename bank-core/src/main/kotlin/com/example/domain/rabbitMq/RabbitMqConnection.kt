package com.example.domain.rabbitMq

import com.rabbitmq.client.Connection
import com.rabbitmq.client.ConnectionFactory

object RabbitMqConnection {
    val connection: Connection by lazy {
        try {
            val factory = ConnectionFactory()
            factory.host = "rabbitmq"
            factory.username = "user"
            factory.password = "password"
            factory.newConnection()
        } catch (e: Exception) {
            println("Ошибка при подключении к RabbitMQ: ${e.message}")
            throw e
        }
    }
}