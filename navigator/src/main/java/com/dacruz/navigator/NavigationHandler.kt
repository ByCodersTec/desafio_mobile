package com.dacruz.navigator

import kotlinx.coroutines.flow.StateFlow

interface NavigationHandler {
    val currentScreen: StateFlow<Screen>
    val transportedData: StateFlow<Any?>

    fun navigateTo(screen: Screen, extra: Any? = null, pop: Screen? = null)
    fun navigateBack(onAppExit: () -> Unit = {})
}