package com.dacruz.bycodersmobile.login.presentation

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.dacruz.bycodersmobile.firebase.data.source.analytics.FirebaseAnalyticsDataSource
import com.dacruz.bycodersmobile.firebase.data.source.crashlytics.FirebaseCrashlyticsDataSource
import com.dacruz.bycodersmobile.login.domain.GetUserUseCase
import com.dacruz.bycodersmobile.login.domain.LoginUseCase
import com.dacruz.bycodersmobile.login.domain.RegisterUseCase
import com.dacruz.bycodersmobile.login.domain.SaveUserUseCase
import com.dacruz.bycodersmobile.login.domain.model.User
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.launch

class LoginViewModel(
    private val loginUseCase: LoginUseCase,
    private val saveUserUseCase: SaveUserUseCase,
    private val registerUseCase: RegisterUseCase,
    private val getUserUseCase: GetUserUseCase,
    private val analytics: FirebaseAnalyticsDataSource,
    private val crashlytics: FirebaseCrashlyticsDataSource
) : ViewModel() {

    val loginState = MutableStateFlow<LoginState>(LoginState.Empty)

    fun login(email: String, password: String) {
        viewModelScope.launch {
            loginUseCase.login(email, password)
                .onStart {
                    loginState.emit(LoginState.Loading)
                    analytics.logEvent("login_started", mapOf("email" to email))
                }
                .catch { error ->
                    loginState.emit(LoginState.Error(error))
                    crashlytics.log("Login error for email: $email")
                    crashlytics.recordException(error)
                }
                .collect { user ->
                    loginState.emit(LoginState.Success(user))
                    saveUser(user)
                    analytics.logEvent("login_success", mapOf("email" to email))
                }
        }
    }

    fun register(email: String, password: String, name: String) {
        viewModelScope.launch {
            registerUseCase.register(email, password, name)
                .onStart {
                    loginState.emit(LoginState.Loading)
                    analytics.logEvent("register_started", mapOf("email" to email))
                }
                .catch { error ->
                    loginState.emit(LoginState.Error(error))
                    crashlytics.log("Registration error for email: $email")
                    crashlytics.recordException(error)
                }
                .collect { registeredUser ->
                    loginState.emit(LoginState.Success(registeredUser))
                    saveUser(registeredUser)
                    analytics.logEvent("register_success", mapOf("email" to email))
                }
        }
    }

    private fun saveUser(user: User) {
        viewModelScope.launch {
            saveUserUseCase.saveUser(user)
            analytics.logEvent("user_saved", mapOf("email" to user.email.toString()))
        }
    }

    suspend fun getUser(): Flow<User?> {
        return getUserUseCase.invoke()
    }

    fun clearComposable() {
        viewModelScope.launch {
            loginState.emit(LoginState.Empty)
        }
    }
}
