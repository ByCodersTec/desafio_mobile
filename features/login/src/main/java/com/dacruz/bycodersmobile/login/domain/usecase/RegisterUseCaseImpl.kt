package com.dacruz.bycodersmobile.login.domain.usecase

import com.dacruz.bycodersmobile.login.domain.LoginRepository
import com.dacruz.bycodersmobile.login.domain.RegisterUseCase
import com.dacruz.bycodersmobile.login.domain.model.User
import kotlinx.coroutines.flow.Flow

class RegisterUseCaseImpl(
    private val loginRepository: LoginRepository
) : RegisterUseCase {

    override suspend fun register(email: String, password: String, name: String): Flow<User> {
        return loginRepository.register(email, password, name)
    }
}
