package com.example.domain.rabbitMq

import com.rabbitmq.client.Channel

object RabbitMqPublisher {
    private val channel: Channel = RabbitMqConnection.connection.createChannel()
    fun publishMessage(queueName: String, message: String) {
        channel.queueDeclare(queueName, false, false, false, null)
        channel.basicPublish("", queueName, null, message.toByteArray())
    }
}