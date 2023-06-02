package com.dacruz.navigator

sealed class Screen {
    object SplashScreen : Screen()
    object LoginScreen : Screen()
    object HomeScreen : Screen()
    object RegisterScreen: Screen()
}
