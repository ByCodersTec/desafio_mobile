package com.dacruz.bycodersmobile.home.data.repository

import com.dacruz.bycodersmobile.home.data.local.HomeLocalDataSource
import com.dacruz.bycodersmobile.home.data.mapper.LocalizationMapper
import com.dacruz.bycodersmobile.home.domain.UserLocalizationRepository
import com.dacruz.bycodersmobile.home.domain.model.Localization

class UserLocalizationRepositoryImpl(
    private val localDataSource: HomeLocalDataSource,
    private val localizationMapper: LocalizationMapper,
) : UserLocalizationRepository {

    override suspend fun getUserLocalization(email: String): Localization? {
        val localizationEntity = localDataSource.getUserLocalization(email)
        return localizationEntity?.let { localizationMapper.mapEntityToDomain(it) }
    }

    override suspend fun insertOrUpdateUserLocalization(localization: Localization) {
        val localizationEntity = localizationMapper.mapDomainToEntity(localization)
        localDataSource.insertOrUpdateUserLocalization(localizationEntity)
    }
}
