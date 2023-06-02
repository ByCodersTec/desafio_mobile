package com.dacruz.bycodersmobile.login.data.local

import com.dacruz.database.UserDao
import com.dacruz.database.model.UserEntity
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class UserLocalDataSourceImpl(
    private val userDao: UserDao
) : UserLocalDataSource {

    override suspend fun getLastLoggedUser(): UserEntity? {
        return withContext(Dispatchers.IO) {
            userDao.getLastLoggedUser()
        }
    }


    override suspend fun insertUser(user: UserEntity) {
        return withContext(Dispatchers.IO) {
            userDao.insertUser(user)
        }
    }
}
