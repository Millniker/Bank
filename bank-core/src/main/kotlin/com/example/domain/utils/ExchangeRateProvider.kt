package com.example.domain.utils

import com.example.data.entities.CurrencyType
import java.math.BigDecimal
import java.math.RoundingMode
import kotlin.random.Random

object ExchangeRateProvider {
    fun getExchangeRate(from: CurrencyType, to: CurrencyType): BigDecimal {
        if (from == to) {
            return BigDecimal.ONE
        }

        return when (from to to) {
            CurrencyType.USD to CurrencyType.EUR -> randomRate(0.8, 0.9)
            CurrencyType.EUR to CurrencyType.USD -> randomRate(1.1, 1.2)
            CurrencyType.USD to CurrencyType.RUB -> randomRate(70.0, 80.0)
            CurrencyType.RUB to CurrencyType.USD -> randomRate(0.012, 0.014)
            CurrencyType.EUR to CurrencyType.RUB -> randomRate(80.0, 90.0)
            CurrencyType.RUB to CurrencyType.EUR -> randomRate(0.01, 0.011)
            else -> BigDecimal.ONE
        }
    }

    private fun randomRate(min: Double, max: Double): BigDecimal {
        return BigDecimal(Random.nextDouble(min, max)).setScale(2, RoundingMode.HALF_EVEN)
    }
}