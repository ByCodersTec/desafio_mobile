package com.dacruz.bycodersmobile.firebase

import com.dacruz.bycodersmobile.firebase.data.source.crashlytics.FirebaseCrashlyticsRepository
import com.google.firebase.crashlytics.FirebaseCrashlytics
import io.mockk.Runs
import io.mockk.clearAllMocks
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.verify
import kotlinx.coroutines.ExperimentalCoroutinesApi
import org.junit.Before
import org.junit.Test

@ExperimentalCoroutinesApi
class FirebaseCrashlyticsRepositoryTest {
    private val mockCrashlytics: FirebaseCrashlytics = mockk()
    private lateinit var crashlyticsRepository: FirebaseCrashlyticsRepository

    @Before
    fun setup() {
        clearAllMocks()
        crashlyticsRepository = FirebaseCrashlyticsRepository(mockCrashlytics)
    }

    @Test
    fun `log correctly logs message with FirebaseCrashlytics`() {
        val message = "Test message"

        every { mockCrashlytics.log(any()) } just Runs

        crashlyticsRepository.log(message)

        verify { mockCrashlytics.log(message) }
    }

    @Test
    fun `recordException correctly records exception with FirebaseCrashlytics`() {
        val exception = RuntimeException()

        every { mockCrashlytics.recordException(any()) } just Runs

        crashlyticsRepository.recordException(exception)

        verify { mockCrashlytics.recordException(exception) }
    }
}
