package com.dacruz.bycodersmobile.login.domain.usecase

import com.dacruz.bycodersmobile.login.domain.LoginRepository
import com.dacruz.bycodersmobile.login.domain.LoginUseCase
import com.dacruz.bycodersmobile.login.domain.model.User
import kotlinx.coroutines.flow.Flow

class LoginUseCaseImpl(
    private val loginRepository: LoginRepository
) : LoginUseCase {

    override suspend fun login(email: String, password: String): Flow<User> {
        return loginRepository.login(email, password)
    }
}
