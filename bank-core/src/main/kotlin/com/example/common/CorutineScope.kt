package com.example.common

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob

val applicationScope = CoroutineScope(SupervisorJob() + Dispatchers.Default)