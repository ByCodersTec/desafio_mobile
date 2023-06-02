package com.dacruz.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Transaction
import com.dacruz.database.model.LocalizationEntity

@Dao
interface LocalizationDao {

    @Query("SELECT * FROM LocalizationEntity WHERE email = :email ORDER BY id DESC LIMIT 1")
    suspend fun getUserLocalization(email: String): LocalizationEntity?

    @Transaction
    suspend fun insertOrUpdateUserLocalization(localization: LocalizationEntity) {
        val existingLocalization = getUserLocalization(localization.email)
        if (existingLocalization != null) {
            localization.id = existingLocalization.id
        }
        insertLocalization(localization)
    }

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertLocalization(localization: LocalizationEntity)
}
