package com.dacruz.navigator

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import java.util.LinkedList

class Navigator : NavigationHandler {
    private val _currentScreen = MutableStateFlow<Screen>(Screen.SplashScreen)
    override val currentScreen: StateFlow<Screen> = _currentScreen

    private val _transportData = MutableStateFlow<Any?>(null)

    override val transportedData: StateFlow<Any?>
        get() {
            val currentValue = _transportData.value
            clearTransportedData()
            return MutableStateFlow(currentValue)
        }

    private val screenHistory = LinkedList<Screen>().apply {
        push(Screen.SplashScreen)
    }

    override fun navigateTo(screen: Screen, extra: Any?, pop: Screen?) {
        _transportData.value = extra
        if (pop != null && screenHistory.peek() == pop) {
            screenHistory.pop()
        }
        screenHistory.push(screen)
        _currentScreen.value = screen
    }

    override fun navigateBack(onAppExit: () -> Unit) {
        if (screenHistory.size > 1) {
            screenHistory.pop()
            _currentScreen.value = screenHistory.peek()
        } else {
            onAppExit()
        }
    }

    private fun  clearTransportedData() {
        _transportData.value = null
    }
}

inline fun <reified T> StateFlow<*>.collectAsType(): T? {
    val currentValue = this.value
    return if (currentValue is T) {
        currentValue
    } else {
        null
    }
}