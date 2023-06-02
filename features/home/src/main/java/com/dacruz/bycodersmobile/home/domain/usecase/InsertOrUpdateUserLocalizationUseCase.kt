package com.dacruz.bycodersmobile.home.domain.usecase

import com.dacruz.bycodersmobile.home.domain.model.Localization

interface InsertOrUpdateUserLocalizationUseCase {
    suspend fun execute(localization: Localization)
}
