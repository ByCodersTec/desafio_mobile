package com.dacruz.theme

import androidx.compose.runtime.compositionLocalOf
import androidx.compose.runtime.mutableStateOf

val LocalIsLightTheme = compositionLocalOf { mutableStateOf(true) }