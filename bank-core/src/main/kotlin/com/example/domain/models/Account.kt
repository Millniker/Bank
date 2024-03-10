package com.example.domain.models

import com.example.data.entities.AccountStatus
import com.example.data.entities.AccountType
import com.example.data.entities.CurrencyType
import com.example.domain.utils.BigDecimalSerializer
import com.example.domain.utils.LocalDateTimeSerializer
import kotlinx.serialization.Contextual
import kotlinx.serialization.Serializable
import java.math.BigDecimal
import java.time.LocalDateTime
import java.time.ZoneOffset

@Serializable
data class Account(
    val id: Int,
    val accountNumber: String,
    val customerId: Int,
    @Serializable(with = BigDecimalSerializer::class) val balance: BigDecimal,
    val currencyType: CurrencyType,
    val accountType: AccountType,
    val accountStatus: AccountStatus,
    @Serializable(with = LocalDateTimeSerializer::class) val openingDate: LocalDateTime = LocalDateTime.now(),
    val interestRate: Float
)
