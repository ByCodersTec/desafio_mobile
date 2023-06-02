package com.dacruz.login.data

import com.dacruz.bycodersmobile.login.data.mapper.UserMapper
import com.dacruz.bycodersmobile.login.domain.model.User
import com.dacruz.database.model.UserEntity
import com.google.common.truth.Truth.assertThat
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import com.dacruz.bycodersmobile.firebase.data.model.User as FirebaseUser

@RunWith(JUnit4::class)
class UserMapperTest {

    private lateinit var mapper: UserMapper

    @Before
    fun setUp() {
        mapper = UserMapper()
    }

    @Test
    fun `mapFirebaseUserToDomain maps correctly`() {
        val firebaseUser = FirebaseUser("1", "test@bycoders.com", "Test User")
        val expectedUser = User(name = "Test User", email = "test@bycoders.com")

        val result = mapper.mapFirebaseUserToDomain(firebaseUser)

        assertThat(result).isEqualTo(expectedUser)
    }

    @Test
    fun `mapDomainToEntity maps correctly`() {
        val user = User(name = "Test User", email = "test@bycoders.com")
        val expectedEntity = UserEntity("test@bycoders.com", "Test User")

        val result = mapper.mapDomainToEntity(user)

        assertThat(result).isEqualTo(expectedEntity)
    }
}
