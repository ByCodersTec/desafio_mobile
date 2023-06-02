package com.dacruz.bycodersmobile.home.domain

import com.dacruz.bycodersmobile.home.domain.model.Localization

interface UserLocalizationRepository  {
    suspend fun getUserLocalization(email: String): Localization?
    suspend fun insertOrUpdateUserLocalization(localization: Localization)
}
