package com.dacruz.bycodersmobile.firebase

import com.dacruz.bycodersmobile.firebase.data.source.analytics.FirebaseAnalyticsRepository
import com.google.firebase.analytics.FirebaseAnalytics
import io.mockk.Runs
import io.mockk.clearAllMocks
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.verify
import kotlinx.coroutines.ExperimentalCoroutinesApi
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner

@ExperimentalCoroutinesApi
@RunWith(RobolectricTestRunner::class)
class FirebaseAnalyticsRepositoryTest {
    private val mockFirebaseAnalytics: FirebaseAnalytics = mockk()
    private lateinit var firebaseAnalyticsRepository: FirebaseAnalyticsRepository

    @Before
    fun setup() {
        clearAllMocks()
        firebaseAnalyticsRepository = FirebaseAnalyticsRepository(mockFirebaseAnalytics)
    }

    @Test
    fun `logEvent correctly logs event with FirebaseAnalytics`() {
        val eventName = "testEvent"
        val params = mapOf("param1" to "value1", "param2" to 2)

        every { mockFirebaseAnalytics.logEvent(any(), any()) } just Runs

        firebaseAnalyticsRepository.logEvent(eventName, params)

        verify {
            mockFirebaseAnalytics.logEvent(
                eventName,
                match { it.getString("param1") == "value1" && it.getInt("param2") == 2 }
            )
        }
    }
}
