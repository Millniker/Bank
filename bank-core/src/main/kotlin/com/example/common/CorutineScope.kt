package com.example.common

import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob

val applicationScope = CoroutineScope(SupervisorJob() + Dispatchers.Default)
val exceptionHandler = CoroutineExceptionHandler { _, exception ->
    throw exception
}