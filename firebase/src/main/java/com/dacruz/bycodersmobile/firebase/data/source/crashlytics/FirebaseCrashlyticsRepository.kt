package com.dacruz.bycodersmobile.firebase.data.source.crashlytics

import com.google.firebase.crashlytics.FirebaseCrashlytics

class FirebaseCrashlyticsRepository(private val crashlytics: FirebaseCrashlytics) : FirebaseCrashlyticsDataSource {
    override fun log(message: String) {
        crashlytics.log(message)
    }

    override fun recordException(e: Throwable) {
        crashlytics.recordException(e)
    }
}
