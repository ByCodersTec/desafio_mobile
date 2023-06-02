package com.dacruz.bycodersmobile.login.domain

import com.dacruz.bycodersmobile.login.domain.model.User
import kotlinx.coroutines.flow.Flow

interface LoginUseCase {
    suspend fun login(email: String, password: String): Flow<User>
}
