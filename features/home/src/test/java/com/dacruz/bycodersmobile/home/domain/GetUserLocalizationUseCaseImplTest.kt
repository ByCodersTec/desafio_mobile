package com.dacruz.bycodersmobile.home.domain

import com.dacruz.bycodersmobile.home.domain.model.Localization
import com.dacruz.bycodersmobile.home.domain.usecase.impl.GetUserLocalizationUseCaseImpl
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class GetUserLocalizationUseCaseImplTest {
    private val userLocalizationRepository: UserLocalizationRepository = mockk(relaxed = true)
    private lateinit var getUserLocalizationUseCase: GetUserLocalizationUseCaseImpl
    private val testEmail = "test@email.com"
    private val localization = Localization(testEmail, 0.0, 0.0)

    @Before
    fun setUp() {
        getUserLocalizationUseCase = GetUserLocalizationUseCaseImpl(userLocalizationRepository)
    }

    @Test
    fun `execute retrieves data correctly`() = runTest {
        coEvery { userLocalizationRepository.getUserLocalization(any()) } returns localization

        val flow = getUserLocalizationUseCase.execute(testEmail)

        flow.collect { result ->
            assertEquals(localization, result)
        }
    }
}
