package com.example.domain.rabbitMq

import com.example.common.exceptionHandler
import com.rabbitmq.client.AMQP
import com.rabbitmq.client.Channel
import com.rabbitmq.client.DefaultConsumer
import com.rabbitmq.client.Envelope
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

object RabbitMqConsumer {
    private val channel: Channel = RabbitMqConnection.connection.createChannel()
    fun consumeMessages(queueName: String, handle: suspend (String) -> Unit) {
        channel.queueDeclare(queueName, false, false, false, null)
        val consumer = object : DefaultConsumer(channel) {
            override fun handleDelivery(consumerTag: String, envelope: Envelope, properties: AMQP.BasicProperties, body: ByteArray) {
                val message = String(body, Charsets.UTF_8)
                CoroutineScope(Dispatchers.IO + exceptionHandler).launch {
                    handle(message)
                }
            }
        }
        channel.basicConsume(queueName, true, consumer)
    }
}