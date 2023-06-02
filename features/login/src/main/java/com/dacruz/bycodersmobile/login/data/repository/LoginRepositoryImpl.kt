package com.dacruz.bycodersmobile.login.data.repository

import com.dacruz.bycodersmobile.firebase.data.source.auth.FirebaseAuthDataSource
import com.dacruz.bycodersmobile.login.data.local.UserLocalDataSource
import com.dacruz.bycodersmobile.login.data.mapper.UserMapper
import com.dacruz.bycodersmobile.login.domain.LoginRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.map
import com.dacruz.bycodersmobile.login.domain.model.User as UserDomain

class LoginRepositoryImpl(
    private val firebaseAuthService: FirebaseAuthDataSource,
    private val localDataSource: UserLocalDataSource,
    private val userMapper: UserMapper
) : LoginRepository {

    override suspend fun login(email: String, password: String): Flow<UserDomain> {
        return firebaseAuthService.login(email, password)
            .map { firebaseUser ->
                userMapper.mapFirebaseUserToDomain(firebaseUser)
            }
    }

    override suspend fun register(email: String, password: String, name: String): Flow<UserDomain> {
        return firebaseAuthService.register(email, password, name)
            .map { registeredUser ->
                userMapper.mapFirebaseUserToDomain(registeredUser)
            }
    }


    override suspend fun saveUser(user: UserDomain) {
        localDataSource.insertUser(userMapper.mapDomainToEntity(user))
    }

    override suspend fun getLastLoggedUser(): Flow<UserDomain?> {
        val userDb = localDataSource.getLastLoggedUser()
        return flow {
            userDb?.let { emit(userMapper.mapEntityToDomain(it)) }
        }
    }
}
