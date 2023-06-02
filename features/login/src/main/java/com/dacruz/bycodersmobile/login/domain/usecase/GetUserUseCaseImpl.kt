package com.dacruz.bycodersmobile.login.domain.usecase

import com.dacruz.bycodersmobile.login.domain.GetUserUseCase
import com.dacruz.bycodersmobile.login.domain.LoginRepository
import kotlinx.coroutines.flow.Flow
import com.dacruz.bycodersmobile.login.domain.model.User as UserDomain

class GetUserUseCaseImpl(
    private val loginRepository: LoginRepository
) : GetUserUseCase {

    override suspend operator fun invoke(): Flow<UserDomain?> {
        return loginRepository.getLastLoggedUser()
    }
}
