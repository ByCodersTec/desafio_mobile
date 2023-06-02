package com.dacruz.login.presentation

import app.cash.turbine.test
import com.dacruz.bycodersmobile.firebase.data.source.analytics.FirebaseAnalyticsDataSource
import com.dacruz.bycodersmobile.firebase.data.source.crashlytics.FirebaseCrashlyticsDataSource
import com.dacruz.bycodersmobile.login.domain.GetUserUseCase
import com.dacruz.bycodersmobile.login.domain.LoginUseCase
import com.dacruz.bycodersmobile.login.domain.RegisterUseCase
import com.dacruz.bycodersmobile.login.domain.SaveUserUseCase
import com.dacruz.bycodersmobile.login.domain.model.User
import com.dacruz.bycodersmobile.login.presentation.LoginState
import com.dacruz.bycodersmobile.login.presentation.LoginViewModel
import com.dacruz.login.CoroutineTestRule
import com.google.common.truth.Truth.assertThat
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.test.runTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test

@ExperimentalCoroutinesApi
class LoginViewModelTest {

    @get:Rule
    val instantTaskExecutorRule = CoroutineTestRule()

    private val loginUseCase: LoginUseCase = mockk(relaxed = true)
    private val saveUserUseCase: SaveUserUseCase = mockk(relaxed = true)
    private val registerUseCase: RegisterUseCase = mockk(relaxed = true)
    private val getUserUseCase: GetUserUseCase = mockk(relaxed = true)
    private val analytics: FirebaseAnalyticsDataSource = mockk(relaxed = true)
    private val crashlytics: FirebaseCrashlyticsDataSource = mockk(relaxed = true)

    private lateinit var viewModel: LoginViewModel

    @Before
    fun setup() {
        viewModel = LoginViewModel(
            loginUseCase,
            saveUserUseCase,
            registerUseCase,
            getUserUseCase,
            analytics,
            crashlytics
        )
    }

    @Test
    fun `test clearComposable`() = runTest {
        viewModel.clearComposable()

        viewModel.loginState.test {
            assertThat(awaitItem()).isEqualTo(LoginState.Empty)
        }
    }

    @Test
    fun `test login success`() = runTest {
        val email = "test@example.com"
        val password = "password"
        val latitude = 0.0
        val longitude = 0.0

        val user =
            User(name = "Test User", email = email, latitude = latitude, longitude = longitude)

        coEvery { loginUseCase.login(email, password) } returns flowOf(user)

        viewModel.login(email, password)

        viewModel.loginState.test {
            assertThat(awaitItem()).isEqualTo(LoginState.Empty)
            assertThat(awaitItem()).isEqualTo(LoginState.Loading)
            assertThat(awaitItem()).isEqualTo(LoginState.Success(user))
        }

        coVerify { analytics.logEvent("login_started", mapOf("email" to email)) }
        coVerify { saveUserUseCase.saveUser(user) }
        coVerify { analytics.logEvent("login_success", mapOf("email" to email)) }
    }


    @Test
    fun `test login error`() = runTest {
        val email = "test@example.com"
        val password = "password"
        val error = RuntimeException("Login failed")

        coEvery { loginUseCase.login(email, password) } returns flow { throw error }

        viewModel.login(email, password)

        viewModel.loginState.test {
            assertThat(awaitItem()).isEqualTo(LoginState.Empty)
            assertThat(awaitItem()).isEqualTo(LoginState.Loading)
            assertThat(awaitItem()).isEqualTo(LoginState.Error(error))
        }

        coVerify(exactly = 1) { analytics.logEvent("login_started", mapOf("email" to email)) }
        coVerify(exactly = 1) { crashlytics.log("Login error for email: $email") }
        coVerify(exactly = 1) { crashlytics.recordException(error) }
    }

}
