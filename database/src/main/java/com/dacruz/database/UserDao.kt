package com.dacruz.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.dacruz.database.model.UserEntity

@Dao
interface UserDao {

    @Query("SELECT * FROM UserEntity ORDER BY lastLogin DESC LIMIT 1")
    suspend fun getLastLoggedUser(): UserEntity?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertUser(user: UserEntity)
}
