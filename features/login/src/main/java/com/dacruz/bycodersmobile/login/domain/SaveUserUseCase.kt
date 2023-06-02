package com.dacruz.bycodersmobile.login.domain

import com.dacruz.bycodersmobile.login.domain.model.User

interface SaveUserUseCase {
    suspend fun saveUser(user: User)
}
