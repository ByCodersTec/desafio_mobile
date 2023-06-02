package com.dacruz.bycodersmobile.firebase

import com.dacruz.bycodersmobile.firebase.data.model.User
import com.dacruz.bycodersmobile.firebase.data.source.auth.FirebaseAuthRepository
import com.google.android.gms.tasks.Tasks
import com.google.common.truth.Truth.assertThat
import com.google.firebase.auth.AuthResult
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import io.mockk.clearAllMocks
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.every
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Before
import org.junit.Test

@ExperimentalCoroutinesApi
class FirebaseAuthRepositoryTest {
    private val mockFirebaseAuth: FirebaseAuth = mockk()
    private lateinit var firebaseAuthRepository: FirebaseAuthRepository

    @Before
    fun setup() {
        clearAllMocks()
        firebaseAuthRepository = FirebaseAuthRepository(mockFirebaseAuth)
    }

    @Test
    fun `login executes with correct email and password`() = runBlockingTest {
        val email = "test@test.com"
        val password = "password"
        val user = User("uid", email, "name")

        val mockAuthResult = mockk<AuthResult>()
        val mockFirebaseUser = mockk<FirebaseUser> {
            every { uid } returns user.uid.toString()
            every { this@mockk.email } returns user.email
            every { displayName } returns user.name
        }

        coEvery { mockAuthResult.user } returns mockFirebaseUser
        coEvery { mockFirebaseAuth.signInWithEmailAndPassword(email, password) } returns
        Tasks.forResult(mockAuthResult)

        val result = firebaseAuthRepository.login(email, password).first()

        assertThat(result).isEqualTo(user)

        coVerify { mockFirebaseAuth.signInWithEmailAndPassword(email, password) }
    }
}
