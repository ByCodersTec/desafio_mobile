package com.dacruz.bycodersmobile.login.domain

import com.dacruz.bycodersmobile.login.domain.model.User
import kotlinx.coroutines.flow.Flow

interface GetUserUseCase {
    suspend operator fun invoke(): Flow<User?>
}
