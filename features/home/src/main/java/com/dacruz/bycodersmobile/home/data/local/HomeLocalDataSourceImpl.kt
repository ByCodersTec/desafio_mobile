package com.dacruz.bycodersmobile.home.data.local

import com.dacruz.database.LocalizationDao
import com.dacruz.database.model.LocalizationEntity
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class HomeLocalDataSourceImpl(
    private val localizationDao: LocalizationDao,
) : HomeLocalDataSource {

    override suspend fun getUserLocalization(email: String): LocalizationEntity? {
        return withContext(Dispatchers.IO) {
            localizationDao.getUserLocalization(email)
        }
    }

    override suspend fun insertOrUpdateUserLocalization(localization: LocalizationEntity) {
        return withContext(Dispatchers.IO) {
            localizationDao.insertOrUpdateUserLocalization(localization)
        }
    }
}
