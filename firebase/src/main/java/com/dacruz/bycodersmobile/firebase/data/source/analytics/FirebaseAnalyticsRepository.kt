package com.dacruz.bycodersmobile.firebase.data.source.analytics

import android.os.Bundle
import com.google.firebase.analytics.FirebaseAnalytics

class FirebaseAnalyticsRepository(private val firebaseAnalytics: FirebaseAnalytics) : FirebaseAnalyticsDataSource {
    override fun logEvent(eventName: String, params: Map<String, Any>) {
        val bundle = Bundle().apply {
            params.forEach { (key, value) ->
                when (value) {
                    is Int -> putInt(key, value)
                    is String -> putString(key, value)
                    is Boolean -> putBoolean(key, value)
                    is Double -> putDouble(key, value)
                     else -> throw IllegalArgumentException("Unsupported value type: ${value::class.java}")
                }
            }
        }
        firebaseAnalytics.logEvent(eventName, bundle)
    }
}
