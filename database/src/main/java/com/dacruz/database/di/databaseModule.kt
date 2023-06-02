package com.dacruz.database.di

import com.dacruz.database.AppDatabase
import com.dacruz.database.AppDatabase.Companion
import org.koin.android.ext.koin.androidApplication
import org.koin.dsl.module

val databaseModule = module {
    single { Companion.getDatabase(androidApplication()) }
    single { get<AppDatabase>().userDao() }
    single { get<AppDatabase>().localizationDao() }
}
