package com.example.domain.rabbitMq

import com.rabbitmq.client.Channel

class RabbitMqPublisher(private val channel: Channel) {
    fun publishMessage(queueName: String, message: String) {
        channel.queueDeclare(queueName, false, false, false, null)
        channel.basicPublish("", queueName, null, message.toByteArray())
    }
}