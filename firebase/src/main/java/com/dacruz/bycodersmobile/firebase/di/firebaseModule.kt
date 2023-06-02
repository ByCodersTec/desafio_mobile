package com.dacruz.bycodersmobile.firebase.di

import com.dacruz.bycodersmobile.firebase.data.source.analytics.FirebaseAnalyticsDataSource
import com.dacruz.bycodersmobile.firebase.data.source.analytics.FirebaseAnalyticsRepository
import com.dacruz.bycodersmobile.firebase.data.source.auth.FirebaseAuthDataSource
import com.dacruz.bycodersmobile.firebase.data.source.auth.FirebaseAuthRepository
import com.dacruz.bycodersmobile.firebase.data.source.crashlytics.FirebaseCrashlyticsDataSource
import com.dacruz.bycodersmobile.firebase.data.source.crashlytics.FirebaseCrashlyticsRepository
import com.dacruz.bycodersmobile.firebase.errors.FirebaseAuthInvalidCredentialsExceptionTransformer
import com.dacruz.bycodersmobile.firebase.errors.FirebaseAuthInvalidUserExceptionTransformer
import com.dacruz.bycodersmobile.firebase.errors.FirebaseAuthMultiFactorExceptionTransformer
import com.dacruz.bycodersmobile.firebase.errors.FirebaseAuthRecentLoginRequiredExceptionTransformer
import com.dacruz.bycodersmobile.firebase.errors.FirebaseAuthUserCollisionExceptionTransformer
import com.dacruz.bycodersmobile.firebase.errors.FirebaseAuthWebExceptionTransformer
import com.dacruz.networking.addTransformers
import com.google.firebase.FirebaseApp
import com.google.firebase.analytics.FirebaseAnalytics
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.crashlytics.FirebaseCrashlytics
import org.koin.android.ext.koin.androidApplication
import org.koin.dsl.module

val firebaseModule = module {

    single {
        FirebaseApp.initializeApp(androidApplication())
        FirebaseAuth.getInstance()
    }
    single<FirebaseAuthDataSource> { FirebaseAuthRepository(get()) }

    single { FirebaseAnalytics.getInstance(androidApplication()) }
    single<FirebaseAnalyticsDataSource> { FirebaseAnalyticsRepository(get()) }

    single { FirebaseCrashlytics.getInstance() }
    single<FirebaseCrashlyticsDataSource> { FirebaseCrashlyticsRepository(get()) }

    val firebaseTransformers = listOf(
        FirebaseAuthInvalidCredentialsExceptionTransformer(),
        FirebaseAuthInvalidUserExceptionTransformer(),
        FirebaseAuthMultiFactorExceptionTransformer(),
        FirebaseAuthRecentLoginRequiredExceptionTransformer(),
        FirebaseAuthUserCollisionExceptionTransformer(),
        FirebaseAuthWebExceptionTransformer()
    )

    addTransformers(*firebaseTransformers.toTypedArray())

}
