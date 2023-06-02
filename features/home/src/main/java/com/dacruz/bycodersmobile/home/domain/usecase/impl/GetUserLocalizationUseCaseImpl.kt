package com.dacruz.bycodersmobile.home.domain.usecase.impl

import com.dacruz.bycodersmobile.home.domain.UserLocalizationRepository
import com.dacruz.bycodersmobile.home.domain.model.Localization
import com.dacruz.bycodersmobile.home.domain.usecase.GetUserLocalizationUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class GetUserLocalizationUseCaseImpl(
    private val userLocalizationRepository: UserLocalizationRepository
) : GetUserLocalizationUseCase {

    override suspend fun execute(email: String): Flow<Localization?> = flow {
        val localization = userLocalizationRepository.getUserLocalization(email)
        emit(localization)
    }
}
