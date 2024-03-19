package com.example.domain.rabbitMq

import com.rabbitmq.client.AMQP
import com.rabbitmq.client.Channel
import com.rabbitmq.client.DefaultConsumer
import com.rabbitmq.client.Envelope

class RabbitMqConsumer(private val channel: Channel) {
    fun consumeMessages(queueName: String, handle: (String) -> Unit) {
        channel.queueDeclare(queueName, false, false, false, null)
        val consumer = object : DefaultConsumer(channel) {
            override fun handleDelivery(consumerTag: String, envelope: Envelope, properties: AMQP.BasicProperties, body: ByteArray) {
                val message = String(body, Charsets.UTF_8)
                handle(message)
            }
        }
        channel.basicConsume(queueName, true, consumer)
    }
}