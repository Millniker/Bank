package com.example.domain.utils

import java.time.Instant
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneOffset

fun secondsToLocalDate(seconds: Long): LocalDate {
    return Instant.ofEpochSecond(seconds).atZone(ZoneOffset.UTC).toLocalDate()
}

fun secondsToLocalDateTime(seconds: Long): LocalDateTime {
    return LocalDateTime.ofInstant(Instant.ofEpochSecond(seconds), ZoneOffset.UTC)
}

fun localDateToSeconds(localDate: LocalDate): Long {
    return localDate.atStartOfDay().toEpochSecond(ZoneOffset.UTC)
}