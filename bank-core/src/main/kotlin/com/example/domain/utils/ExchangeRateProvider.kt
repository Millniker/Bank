package com.example.domain.utils

import com.example.data.entities.CurrencyType
import io.ktor.client.*
import io.ktor.client.engine.cio.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import kotlinx.serialization.json.*
import java.math.BigDecimal
import java.math.RoundingMode
import java.time.Duration
import java.time.LocalDateTime

object ExchangeRateProvider {
    private val httpClient = HttpClient(CIO)
    private val ratesCache = mutableMapOf<Pair<CurrencyType, CurrencyType>, Pair<BigDecimal, LocalDateTime>>()
    private val cacheDuration = Duration.ofHours(1)

    suspend fun getExchangeRate(from: CurrencyType, to: CurrencyType): BigDecimal {
        if (from == to) {
            return BigDecimal.ONE
        }

        val rateKey = from to to
        val now = LocalDateTime.now()

        ratesCache[rateKey]?.let { (rate, timestamp) ->
            if (Duration.between(timestamp, now) < (cacheDuration)) {
                return rate
            }
        }

        val rates = getExchangeRates(from.name)
        val rate = rates[to.name]?.toBigDecimal()?.setScale(2, RoundingMode.HALF_EVEN) ?: return BigDecimal.ONE

        ratesCache[rateKey] = rate to now
        return rate
    }

    private suspend fun getExchangeRates(baseCurrency: String): Map<String, Double> {
        val apiKey = "a20657ca3bef442b590d3776"
        val url = "https://v6.exchangerate-api.com/v6/$apiKey/latest/$baseCurrency"

        return try {
            val response: HttpResponse = httpClient.get(url)
            val jsonResponse = Json.parseToJsonElement(response.bodyAsText()).jsonObject
            val conversionRates = jsonResponse["conversion_rates"]?.jsonObject
            conversionRates?.mapValues { it.value.jsonPrimitive.doubleOrNull ?: 0.0 } ?: emptyMap()
        } catch (e: Exception) {
            e.printStackTrace()
            emptyMap()
        }
    }
}