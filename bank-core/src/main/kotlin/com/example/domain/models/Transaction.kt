package com.example.domain.models

import com.example.data.entities.TransactionType
import com.example.domain.utils.BigDecimalSerializer
import com.example.domain.utils.LocalDateTimeSerializer
import kotlinx.serialization.Contextual
import kotlinx.serialization.Serializable
import java.math.BigDecimal
import java.time.LocalDateTime
import java.time.ZoneOffset

@Serializable
data class Transaction(
    val id: Int,
    @Serializable(with = BigDecimalSerializer::class) val amount: BigDecimal,
    val fromAccountId: Int?,
    val toAccountId: Int?,
    val transactionType: TransactionType,
    @Serializable(with = LocalDateTimeSerializer::class) val transactionDate: LocalDateTime = LocalDateTime.now(),
)
