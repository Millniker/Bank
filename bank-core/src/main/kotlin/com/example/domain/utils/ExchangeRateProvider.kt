package com.example.domain.utils

import com.example.data.entities.CurrencyType
import io.ktor.client.*
import io.ktor.client.engine.cio.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.double
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import java.math.BigDecimal
import java.math.RoundingMode

object ExchangeRateProvider {
    private val ratesCache = mutableMapOf<Pair<CurrencyType, CurrencyType>, BigDecimal>()

    suspend fun getExchangeRate(from: CurrencyType, to: CurrencyType): BigDecimal {
        if (from == to) {
            return BigDecimal.ONE
        }

        val rateKey = from to to

        ratesCache[rateKey]?.let { return it }

        val rates = getExchangeRates(from.name)
        val rate = rates[to.name]?.toBigDecimal()?.setScale(2, RoundingMode.HALF_EVEN)
            ?: return BigDecimal.ONE

        ratesCache[rateKey] = rate
        return rate
    }

    private suspend fun getExchangeRates(baseCurrency: String): Map<String, Double> {
        val client = HttpClient(CIO)
        val apiKey = " a20657ca3bef442b590d3776"
        val url = "https://v6.exchangerate-api.com/v6/$apiKey/latest/$baseCurrency"
        val conversionRatesPropertyName = "conversion_rates"

        try {
            val response: HttpResponse = client.get(url)
            val jsonResponse = Json.parseToJsonElement(response.bodyAsText()).jsonObject
            val ratesJsonObject = jsonResponse[conversionRatesPropertyName]!!.jsonObject
            return ratesJsonObject.mapValues { it.value.jsonPrimitive.double }
        } catch (e: Exception) {
            e.printStackTrace()
            return emptyMap()
        } finally {
            client.close()
        }
    }
}