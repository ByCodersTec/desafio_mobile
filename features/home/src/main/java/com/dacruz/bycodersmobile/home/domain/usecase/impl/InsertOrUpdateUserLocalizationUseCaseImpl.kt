package com.dacruz.bycodersmobile.home.domain.usecase.impl

import com.dacruz.bycodersmobile.home.domain.UserLocalizationRepository
import com.dacruz.bycodersmobile.home.domain.model.Localization
import com.dacruz.bycodersmobile.home.domain.usecase.InsertOrUpdateUserLocalizationUseCase

class InsertOrUpdateUserLocalizationUseCaseImpl(
    private val homeRepository: UserLocalizationRepository
) : InsertOrUpdateUserLocalizationUseCase {

    override suspend fun execute(localization: Localization) {
        homeRepository.insertOrUpdateUserLocalization(localization)
    }
}
