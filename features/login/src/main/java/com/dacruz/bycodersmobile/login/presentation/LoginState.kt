package com.dacruz.bycodersmobile.login.presentation

import com.dacruz.bycodersmobile.login.domain.model.User

sealed class LoginState {
    object Empty : LoginState()
    object Loading : LoginState()
    data class Success(val user: User) : LoginState()
    data class Error(val error: Throwable) : LoginState()
}
