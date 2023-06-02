package com.dacruz.bycodersmobile.home.domain.usecase

import com.dacruz.bycodersmobile.home.domain.model.Localization
import kotlinx.coroutines.flow.Flow

interface GetUserLocalizationUseCase {
    suspend fun execute(email: String): Flow<Localization?>
}
