package com.example.domain.models

import com.example.data.entities.CurrencyType
import com.example.domain.utils.BigDecimalSerializer
import kotlinx.serialization.Contextual
import kotlinx.serialization.Serializable
import java.math.BigDecimal

data class Money(
    val amount: BigDecimal,
    val currencyType: CurrencyType
) {
    fun convertTo(targetCurrency: CurrencyType, exchangeRate: BigDecimal): Money {
        if (currencyType == targetCurrency) {
            return this
        }
        val convertedAmount = amount.multiply(exchangeRate)
        return Money(convertedAmount, targetCurrency)
    }
}