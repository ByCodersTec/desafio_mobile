package com.dacruz.bycodersmobile.firebase.data.source.auth

import com.dacruz.bycodersmobile.firebase.data.model.User
import kotlinx.coroutines.flow.Flow

interface FirebaseAuthDataSource {
    suspend fun login(email: String, password: String): Flow<User>
    suspend fun register(email: String, password: String, name: String): Flow<User>
    fun logout()
}
