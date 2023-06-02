package com.dacruz.bycodersmobile.login.domain.usecase

import com.dacruz.bycodersmobile.login.domain.LoginRepository
import com.dacruz.bycodersmobile.login.domain.SaveUserUseCase
import com.dacruz.bycodersmobile.login.domain.model.User

class SaveUserUseCaseImpl(
    private val loginRepository: LoginRepository
) : SaveUserUseCase {

    override suspend fun saveUser(user: User) {
        loginRepository.saveUser(user)
    }
}
