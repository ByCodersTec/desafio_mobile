package com.dacruz.bycodersmobile.firebase.data.source.crashlytics

interface FirebaseCrashlyticsDataSource {
    fun log(message: String)
    fun recordException(e: Throwable)
}
