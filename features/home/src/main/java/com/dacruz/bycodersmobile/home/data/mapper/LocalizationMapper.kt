package com.dacruz.bycodersmobile.home.data.mapper

import com.dacruz.bycodersmobile.home.domain.model.Localization
import com.dacruz.database.model.LocalizationEntity

class LocalizationMapper {
    fun mapDomainToEntity(localization: Localization): LocalizationEntity {
        return LocalizationEntity(
            email = localization.email,
            latitude = localization.latitude,
            longitude = localization.longitude
        )
    }

    fun mapEntityToDomain(localizationEntity: LocalizationEntity): Localization {
        return Localization(
            email = localizationEntity.email,
            latitude = localizationEntity.latitude,
            longitude = localizationEntity.longitude
        )
    }
}
