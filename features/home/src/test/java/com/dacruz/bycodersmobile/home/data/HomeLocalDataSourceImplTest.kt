package com.dacruz.bycodersmobile.home.data

import com.dacruz.bycodersmobile.home.data.local.HomeLocalDataSourceImpl
import com.dacruz.database.LocalizationDao
import com.dacruz.database.model.LocalizationEntity
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class HomeLocalDataSourceImplTest {
    private val localizationDao: LocalizationDao = mockk(relaxed = true)
    private lateinit var localDataSource: HomeLocalDataSourceImpl
    private val testEmail = "test@email.com"
    private val localizationEntity = LocalizationEntity(1,  testEmail,0.0, 0.0)

    @Before
    fun setUp() {
        localDataSource = HomeLocalDataSourceImpl(localizationDao)
    }

    @Test
    fun `getUserLocalization retrieves data successfully`() = runTest {
        coEvery { localizationDao.getUserLocalization(any()) } returns localizationEntity

        val result = localDataSource.getUserLocalization(testEmail)

        assertEquals(localizationEntity, result)
    }

    @Test
    fun `insertOrUpdateUserLocalization updates data successfully`() = runTest {
        coEvery { localizationDao.insertOrUpdateUserLocalization(any()) } returns Unit

        localDataSource.insertOrUpdateUserLocalization(localizationEntity)

        coVerify { localizationDao.insertOrUpdateUserLocalization(localizationEntity) }
    }
}
