package com.dacruz.database

import android.content.Context
import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.dacruz.database.model.LocalizationEntity
import com.dacruz.database.model.UserEntity
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class DatabaseTest {

    @OptIn(ExperimentalCoroutinesApi::class)
    @get:Rule
    val instantTaskExecutorRule = CoroutineTestRule()

    private lateinit var database: AppDatabase
    private lateinit var userDao: UserDao
    private lateinit var localizationDao: LocalizationDao

    @Before
    fun setup() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        database = Room.inMemoryDatabaseBuilder(context, AppDatabase::class.java)
            .allowMainThreadQueries()
            .build()

        userDao = database.userDao()
        localizationDao = database.localizationDao()
    }

    @After
    fun teardown() {
        database.close()
    }

    @ExperimentalCoroutinesApi
    @Test
    fun insertUserAndRead() = runTest {
        val user = UserEntity("test@example.com", "Test Name")
        userDao.insertUser(user)

        val retrievedUser = userDao.getLastLoggedUser()

        assertEquals(user, retrievedUser)
    }

    @ExperimentalCoroutinesApi
    @Test
    fun insertLocalizationAndRead() = runTest {
        val localization = LocalizationEntity(0, "test@example.com", 1.0, 1.0)
        localizationDao.insertOrUpdateUserLocalization(localization)

        val retrievedLocalization = localizationDao.getUserLocalization(localization.email)

        assertEquals(localization.email, retrievedLocalization?.email)
        retrievedLocalization?.latitude?.let { assertEquals(localization.latitude, it, 0.0) }
        retrievedLocalization?.longitude?.let { assertEquals(localization.longitude, it, 0.0) }
    }
}
