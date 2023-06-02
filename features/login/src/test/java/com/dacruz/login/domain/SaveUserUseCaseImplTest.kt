package com.dacruz.login.domain

import com.dacruz.bycodersmobile.login.domain.LoginRepository
import com.dacruz.bycodersmobile.login.domain.model.User
import com.dacruz.bycodersmobile.login.domain.usecase.SaveUserUseCaseImpl
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.Before
import org.junit.Test

@ExperimentalCoroutinesApi
class SaveUserUseCaseImplTest {

    private val loginRepository = mockk<LoginRepository>(relaxed = true)
    private lateinit var useCase: SaveUserUseCaseImpl

    @Before
    fun setUp() {
        useCase = SaveUserUseCaseImpl(loginRepository)
    }

    @Test
    fun `saveUser calls repository`() = runTest {
        val user = User(name = "Test", email = "test@bycoders.com")

        useCase.saveUser(user)

        coVerify { loginRepository.saveUser(user) }
    }
}
