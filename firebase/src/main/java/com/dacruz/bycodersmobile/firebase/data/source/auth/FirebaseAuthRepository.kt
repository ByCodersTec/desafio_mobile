package com.dacruz.bycodersmobile.firebase.data.source.auth

import com.dacruz.bycodersmobile.firebase.data.model.User
import com.dacruz.networking.executeRequest
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.UserProfileChangeRequest
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.tasks.await

class FirebaseAuthRepository(private val firebaseAuth: FirebaseAuth) : FirebaseAuthDataSource {

    override suspend fun login(email: String, password: String): Flow<User> {
        return flow {
            executeRequest {
                val authResult = firebaseAuth.signInWithEmailAndPassword(email, password).await()
                val firebaseUser = authResult.user
                val user = User(
                    uid = firebaseUser?.uid,
                    email = firebaseUser?.email,
                    name = firebaseUser?.displayName,
                )
                emit(user)
            }
        }
    }

    override suspend fun register(email: String, password: String, name: String): Flow<User> {
        return flow {
            executeRequest {
                val authResult = firebaseAuth.createUserWithEmailAndPassword(email, password).await()
                val firebaseUser = authResult.user
                val profileUpdates = UserProfileChangeRequest.Builder()
                    .setDisplayName(name)
                    .build()
                firebaseUser?.updateProfile(profileUpdates)?.await()
                val updatedFirebaseUser = firebaseAuth.currentUser
                val updatedUser = User(
                    uid = updatedFirebaseUser?.uid,
                    email = updatedFirebaseUser?.email,
                    name = updatedFirebaseUser?.displayName,
                )
                emit(updatedUser)
            }
        }
    }


    override fun logout() {
        firebaseAuth.signOut()
    }
}
