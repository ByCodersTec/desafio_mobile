package com.dacruz.bycodersmobile.home.data

import com.dacruz.bycodersmobile.home.data.mapper.LocalizationMapper
import com.dacruz.bycodersmobile.home.domain.model.Localization
import com.dacruz.database.model.LocalizationEntity
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

class LocalizationMapperTest {
    private lateinit var mapper: LocalizationMapper
    private val testEmail = "test@email.com"
    private val localizationEntity = LocalizationEntity(0,  testEmail,0.0, 0.0)
    private val localization = Localization(testEmail, 0.0, 0.0)

    @Before
    fun setUp() {
        mapper = LocalizationMapper()
    }

    @Test
    fun `mapDomainToEntity maps data correctly`() {
        val result = mapper.mapDomainToEntity(localization)

        assertEquals(localizationEntity, result)
    }

    @Test
    fun `mapEntityToDomain maps data correctly`() {
        val result = mapper.mapEntityToDomain(localizationEntity)

        assertEquals(localization, result)
    }
}
