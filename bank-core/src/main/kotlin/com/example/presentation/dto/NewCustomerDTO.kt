package com.example.presentation.dto

import com.example.domain.models.Customer
import com.example.domain.utils.LocalDateSerializer
import kotlinx.serialization.Contextual
import kotlinx.serialization.Serializable
import java.time.LocalDate

@Serializable
data class NewCustomerDTO(
    val fullName: String,
    @Serializable(with = LocalDateSerializer::class) val dateOfBirth: LocalDate,
    val passportDetails: String,
    val userId: String
) {
    fun toCustomer(): Customer =
        Customer(
            id = 0,
            fullName = fullName,
            dateOfBirth = dateOfBirth,
            passportDetails = passportDetails,
            userId = userId,
        )
}
