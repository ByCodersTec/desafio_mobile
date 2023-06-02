package com.dacruz.bycodersmobile.home.presentation

import app.cash.turbine.test
import com.dacruz.bycodersmobile.firebase.data.source.analytics.FirebaseAnalyticsDataSource
import com.dacruz.bycodersmobile.firebase.data.source.crashlytics.FirebaseCrashlyticsDataSource
import com.dacruz.bycodersmobile.home.CoroutineTestRule
import com.dacruz.bycodersmobile.home.domain.model.Localization
import com.dacruz.bycodersmobile.home.domain.usecase.GetUserLocalizationUseCase
import com.dacruz.bycodersmobile.home.domain.usecase.InsertOrUpdateUserLocalizationUseCase
import com.google.common.truth.Truth.assertThat
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.mockk
import io.mockk.verify
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.test.runTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test

@ExperimentalCoroutinesApi
class HomeViewModelTest {

    @get:Rule
    val coroutineTestRule = CoroutineTestRule()

    private val getUserLocalizationUseCase: GetUserLocalizationUseCase = mockk(relaxed = true)
    private val insertOrUpdateUserLocalizationUseCase: InsertOrUpdateUserLocalizationUseCase = mockk(relaxed = true)
    private val analytics: FirebaseAnalyticsDataSource = mockk(relaxed = true)
    private val crashlytics: FirebaseCrashlyticsDataSource = mockk(relaxed = true)

    private lateinit var viewModel: HomeViewModel
    private val testEmail = "test@email.com"
    private val localization = Localization(testEmail, 0.0, 0.0)

    @Before
    fun setUp() {
        viewModel = HomeViewModel(getUserLocalizationUseCase, insertOrUpdateUserLocalizationUseCase, analytics, crashlytics)
    }

    @Test
    fun `getUserLocalization retrieves data correctly`() = runTest {
        coEvery { getUserLocalizationUseCase.execute(any()) } returns flowOf(localization)

        viewModel.getUserLocalization(testEmail)

        // Permitindo algum tempo para a operação concluir
        delay(1000)

        viewModel.userLocalization.test {
            assertThat(awaitItem()).isEqualTo(localization)
            expectNoEvents()
        }

        coVerify { getUserLocalizationUseCase.execute(testEmail) }
    }

    @Test
    fun `insertOrUpdateUserLocalization updates data correctly`() = runTest {

        coEvery { insertOrUpdateUserLocalizationUseCase.execute(any()) } returns Unit

        viewModel.insertOrUpdateUserLocalization(testEmail, localization.latitude, localization.longitude)

        // Permitindo algum tempo para a operação concluir
        delay(1000)

        viewModel.userLocalization.test {
            assertThat(awaitItem()).isEqualTo(localization)
            expectNoEvents()
        }

        coVerify { insertOrUpdateUserLocalizationUseCase.execute(localization) }
    }


    @Test
    fun `clearComposable clears mapState`() = runTest {
        viewModel.clearComposable()

        viewModel.mapState.test {
            assertThat(awaitItem()).isEqualTo(HomeState.Empty)
        }
    }

    @Test
    fun `setError sets error state and logs crash`() = runTest {
        val exception = Exception("Test exception")

        viewModel.setError(exception)

        viewModel.mapState.test {
            assertThat(awaitItem()).isEqualTo(HomeState.Error(exception))
        }

        verify { crashlytics.log("Home error: ${exception.localizedMessage}") }
        verify { crashlytics.recordException(exception) }
    }
}
