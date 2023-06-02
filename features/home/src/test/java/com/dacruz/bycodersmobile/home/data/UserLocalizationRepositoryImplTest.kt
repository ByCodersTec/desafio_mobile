package com.dacruz.bycodersmobile.home.data

import com.dacruz.bycodersmobile.home.data.local.HomeLocalDataSource
import com.dacruz.bycodersmobile.home.data.mapper.LocalizationMapper
import com.dacruz.bycodersmobile.home.data.repository.UserLocalizationRepositoryImpl
import com.dacruz.bycodersmobile.home.domain.model.Localization
import com.dacruz.database.model.LocalizationEntity
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.every
import io.mockk.mockk
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class UserLocalizationRepositoryImplTest {
    private val homeLocalDataSource: HomeLocalDataSource = mockk(relaxed = true)
    private val localizationMapper: LocalizationMapper = mockk(relaxed = true)
    private lateinit var repository: UserLocalizationRepositoryImpl
    private val testEmail = "test@email.com"
    private val localizationEntity = LocalizationEntity(1,  testEmail,0.0, 0.0)
    private val localization = Localization(testEmail, 0.0, 0.0)

    @Before
    fun setUp() {
        repository = UserLocalizationRepositoryImpl(homeLocalDataSource, localizationMapper)
    }

    @Test
    fun `getUserLocalization retrieves data successfully`() = runTest {
        coEvery { homeLocalDataSource.getUserLocalization(any()) } returns localizationEntity
        every { localizationMapper.mapEntityToDomain(any()) } returns localization

        val result = repository.getUserLocalization(testEmail)

        assertEquals(localization, result)
    }

    @Test
    fun `insertOrUpdateUserLocalization updates data successfully`() = runTest {
        coEvery { homeLocalDataSource.insertOrUpdateUserLocalization(any()) } returns Unit
        every { localizationMapper.mapDomainToEntity(any()) } returns localizationEntity

        repository.insertOrUpdateUserLocalization(localization)

        coVerify { homeLocalDataSource.insertOrUpdateUserLocalization(localizationEntity) }
    }
}
