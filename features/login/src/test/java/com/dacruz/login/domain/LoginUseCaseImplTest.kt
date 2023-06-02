package com.dacruz.login.domain

import com.dacruz.bycodersmobile.login.domain.LoginRepository
import com.dacruz.bycodersmobile.login.domain.model.User
import com.dacruz.bycodersmobile.login.domain.usecase.LoginUseCaseImpl
import com.google.common.truth.Truth.assertThat
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.test.runTest
import org.junit.Before
import org.junit.Test

@ExperimentalCoroutinesApi
class LoginUseCaseImplTest {

    private val loginRepository = mockk<LoginRepository>(relaxed = true)
    private lateinit var useCase: LoginUseCaseImpl

    @Before
    fun setUp() {
        useCase = LoginUseCaseImpl(loginRepository)
    }

    @Test
    fun `login calls repository`() = runTest {
        val email = "test@bycoders.com"
        val password = "test123"
        val user = User(name = "Test", email = email)

        coEvery { loginRepository.login(email, password) } returns flowOf(user)
        val result = useCase.login(email, password).first()

        assertThat(result).isEqualTo(user)
        coVerify { loginRepository.login(email, password) }
    }
}
