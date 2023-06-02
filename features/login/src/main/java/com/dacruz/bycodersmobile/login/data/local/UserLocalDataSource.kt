package com.dacruz.bycodersmobile.login.data.local

import com.dacruz.database.model.UserEntity

interface UserLocalDataSource {
    suspend fun getLastLoggedUser(): UserEntity?
    suspend fun insertUser(user: UserEntity)
}
