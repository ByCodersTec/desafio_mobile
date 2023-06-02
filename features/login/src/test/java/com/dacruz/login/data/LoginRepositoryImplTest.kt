package com.dacruz.login.data

import com.dacruz.bycodersmobile.firebase.data.source.auth.FirebaseAuthDataSource
import com.dacruz.bycodersmobile.login.data.local.UserLocalDataSource
import com.dacruz.bycodersmobile.login.data.mapper.UserMapper
import com.dacruz.bycodersmobile.login.data.repository.LoginRepositoryImpl
import com.dacruz.bycodersmobile.login.domain.model.User
import com.dacruz.database.model.UserEntity
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.just
import io.mockk.mockk
import io.mockk.runs
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.flow.single
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test
import com.dacruz.bycodersmobile.firebase.data.model.User as FirebaseUser

@ExperimentalCoroutinesApi
class LoginRepositoryImplTest {

    private val firebaseAuthService = mockk<FirebaseAuthDataSource>()
    private val localDataSource = mockk<UserLocalDataSource>()
    private val userMapper = mockk<UserMapper>()
    private lateinit var repository: LoginRepositoryImpl

    @Before
    fun setUp() {
        repository = LoginRepositoryImpl(firebaseAuthService, localDataSource, userMapper)
    }

    @Test
    fun `login calls FirebaseAuthService and UserMapper`() = runTest {
        val email = "test@bycoders.com"
        val password = "test123"
        val firebaseUser = mockk<FirebaseUser>()
        val domainUser = mockk<User>()
        val flow = flowOf(firebaseUser)

        coEvery { firebaseAuthService.login(email, password) } returns flow
        coEvery { userMapper.mapFirebaseUserToDomain(firebaseUser) } returns domainUser

        val result = repository.login(email, password).single()

        coVerify { firebaseAuthService.login(email, password) }
        coVerify { userMapper.mapFirebaseUserToDomain(firebaseUser) }
        assertEquals(domainUser, result)
    }

    @Test
    fun `saveUser calls UserMapper and LocalDataSource`() = runTest {
        val user = mockk<User>()
        val entity = mockk<UserEntity>()

        coEvery { userMapper.mapDomainToEntity(user) } returns entity
        coEvery { localDataSource.insertUser(entity) } just runs // Configura o comportamento esperado

        repository.saveUser(user)

        coVerify { userMapper.mapDomainToEntity(user) }
        coVerify { localDataSource.insertUser(entity) }
    }
}
