package com.example.presentation.dto

import com.example.data.entities.CurrencyType
import com.example.domain.models.Money
import com.example.domain.utils.BigDecimalSerializer
import kotlinx.serialization.Contextual
import kotlinx.serialization.Serializable
import java.math.BigDecimal

@Serializable
data class WithdrawDTO(
    val accountId: Int,
    @Serializable(with = BigDecimalSerializer::class) val amount: BigDecimal,
    val currencyType: CurrencyType
) {
    fun toMoney(): Money =
        Money(
            amount = amount,
            currencyType = currencyType
        )
}

