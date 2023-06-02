package com.dacruz.bycodersmobile.home.data.local

import com.dacruz.database.model.LocalizationEntity

interface HomeLocalDataSource {
    suspend fun getUserLocalization(email: String): LocalizationEntity?
    suspend fun insertOrUpdateUserLocalization(localization: LocalizationEntity)
}
