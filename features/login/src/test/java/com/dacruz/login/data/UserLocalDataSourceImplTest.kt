package com.dacruz.login.data

import com.dacruz.bycodersmobile.login.data.local.UserLocalDataSourceImpl
import com.dacruz.database.UserDao
import com.dacruz.database.model.UserEntity
import com.google.common.truth.Truth.assertThat
import io.mockk.Runs
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.just
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.Before
import org.junit.Test

@ExperimentalCoroutinesApi
class UserLocalDataSourceImplTest {
    private val userDao = mockk<UserDao>()
    private lateinit var dataSource: UserLocalDataSourceImpl

    @Before
    fun setUp() {
        dataSource = UserLocalDataSourceImpl(userDao)
    }

    @Test
    fun `getUser returns UserEntity when user is found`() = runTest {
        val testEmail = "test@test.com"
        val expectedUser = UserEntity("Test User", testEmail)
        coEvery { userDao.getLastLoggedUser() } returns expectedUser

        val result = dataSource.getLastLoggedUser()

        assertThat(result).isEqualTo(expectedUser)
    }

    @Test
    fun `getUser returns null when user is not found`() = runTest {
        val testEmail = "notfound@test.com"
        coEvery { userDao.getLastLoggedUser() } returns null

        val result = dataSource.getLastLoggedUser()

        assertThat(result).isNull()
    }

    @Test
    fun `insertUser successfully inserts user`() = runTest {
        val testUser = UserEntity("Test User", "test@test.com")
        coEvery { userDao.insertUser(testUser) } just Runs

        dataSource.insertUser(testUser)

        coVerify (exactly = 1) { userDao.insertUser(testUser) }
    }
}
