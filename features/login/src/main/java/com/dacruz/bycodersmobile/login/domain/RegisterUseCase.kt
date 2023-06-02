package com.dacruz.bycodersmobile.login.domain

import com.dacruz.bycodersmobile.login.domain.model.User
import kotlinx.coroutines.flow.Flow

interface RegisterUseCase {
    suspend fun register(email: String, password: String, name: String): Flow<User>
}
