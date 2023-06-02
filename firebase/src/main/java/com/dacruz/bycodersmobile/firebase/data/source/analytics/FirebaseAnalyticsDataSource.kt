package com.dacruz.bycodersmobile.firebase.data.source.analytics

interface FirebaseAnalyticsDataSource {
    fun logEvent(eventName: String, params: Map<String, Any>)
}
