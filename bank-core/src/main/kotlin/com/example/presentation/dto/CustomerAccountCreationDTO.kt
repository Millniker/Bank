package com.example.presentation.dto

import kotlinx.serialization.Serializable

@Serializable
data class CustomerAccountCreationDTO(
    val customer: NewCustomerDTO,
    val account: CreateAccountDTO
)
