package com.dacruz.bycodersmobile.home.domain

import com.dacruz.bycodersmobile.home.domain.model.Localization
import com.dacruz.bycodersmobile.home.domain.usecase.impl.InsertOrUpdateUserLocalizationUseCaseImpl
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.test.runTest
import org.junit.Before
import org.junit.Test

class InsertOrUpdateUserLocalizationUseCaseImplTest {
    private val userLocalizationRepository: UserLocalizationRepository = mockk(relaxed = true)
    private lateinit var insertOrUpdateUserLocalizationUseCase: InsertOrUpdateUserLocalizationUseCaseImpl
    private val localization = Localization("test@email.com", 0.0, 0.0)

    @Before
    fun setUp() {
        insertOrUpdateUserLocalizationUseCase = InsertOrUpdateUserLocalizationUseCaseImpl(userLocalizationRepository)
    }

    @Test
    fun `execute updates data correctly`() = runTest {
        coEvery { userLocalizationRepository.insertOrUpdateUserLocalization(any()) } returns Unit

        insertOrUpdateUserLocalizationUseCase.execute(localization)

        coVerify { userLocalizationRepository.insertOrUpdateUserLocalization(localization) }
    }
}
