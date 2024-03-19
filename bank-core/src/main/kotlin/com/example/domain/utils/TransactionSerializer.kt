package com.example.domain.utils

import com.example.domain.models.Transaction
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import kotlinx.serialization.modules.SerializersModule
import java.math.BigDecimal
import java.time.LocalDateTime

object JsonUtil {
    private val json = Json {
        serializersModule = SerializersModule {
            contextual(BigDecimal::class, BigDecimalSerializer)
            contextual(LocalDateTime::class, LocalDateTimeSerializer)
        }
    }

    fun serializeTransaction(transaction: Transaction): String {
        return json.encodeToString(transaction)
    }

    fun deserializeTransaction(jsonString: String): Transaction {
        return json.decodeFromString(jsonString)
    }
}