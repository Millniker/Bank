package com.example.presentation.dto

import com.example.data.entities.AccountRequestStatus
import kotlinx.serialization.Serializable

@Serializable
data class StatusUpdateDTO(
    val status: AccountRequestStatus
)