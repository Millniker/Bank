package com.example.presentation.dto

import com.example.data.entities.AccountType
import com.example.data.entities.CurrencyType
import com.example.domain.utils.BigDecimalSerializer
import kotlinx.serialization.Serializable
import java.math.BigDecimal

@Serializable
data class CreateAccountDTO(
    @Serializable(with = BigDecimalSerializer::class) val initialDeposit: BigDecimal,
    val currencyType: CurrencyType,
    val accountType: AccountType,
    val interestRate: Float
)
