package com.dacruz.bycodersmobile.login.domain

import com.dacruz.bycodersmobile.login.domain.model.User
import kotlinx.coroutines.flow.Flow
import com.dacruz.bycodersmobile.login.domain.model.User as UserDomain

interface LoginRepository {
    suspend fun login(email: String, password: String): Flow<User>
    suspend fun register(email: String, password: String, name: String): Flow<UserDomain>
    suspend fun saveUser(user: User)
    suspend fun getLastLoggedUser(): Flow<UserDomain?>
}
