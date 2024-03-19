package com.example.presentation.dto

import com.example.data.entities.CurrencyType
import com.example.domain.utils.BigDecimalSerializer
import kotlinx.serialization.Serializable
import java.math.BigDecimal

@Serializable
data class TransferRequestDTO(
    val fromAccountId: Int,
    val toAccountId: Int,
    @Serializable(with = BigDecimalSerializer::class) val amount: BigDecimal,
    val currencyType: CurrencyType
)