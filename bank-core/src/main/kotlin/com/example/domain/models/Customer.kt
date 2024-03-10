package com.example.domain.models

import com.example.domain.utils.LocalDateSerializer
import com.example.domain.utils.LocalDateTimeSerializer
import kotlinx.serialization.Contextual
import kotlinx.serialization.Serializable
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneOffset

@Serializable
data class Customer(
    val id: Int,
    val fullName: String,
    @Serializable(with = LocalDateSerializer::class) val dateOfBirth: LocalDate,
    val passportDetails: String,
    @Serializable(with = LocalDateTimeSerializer::class) val registrationDate: LocalDateTime = LocalDateTime.now(),
    val userId: String,
)