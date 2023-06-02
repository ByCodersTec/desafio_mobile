package com.dacruz.bycodersmobile.home.presentation

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.dacruz.bycodersmobile.firebase.data.source.analytics.FirebaseAnalyticsDataSource
import com.dacruz.bycodersmobile.firebase.data.source.crashlytics.FirebaseCrashlyticsDataSource
import com.dacruz.bycodersmobile.home.domain.model.Localization
import com.dacruz.bycodersmobile.home.domain.usecase.GetUserLocalizationUseCase
import com.dacruz.bycodersmobile.home.domain.usecase.InsertOrUpdateUserLocalizationUseCase
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.launch

class HomeViewModel(
    private val getUserLocalizationUseCase: GetUserLocalizationUseCase,
    private val insertOrUpdateUserLocalizationUseCase: InsertOrUpdateUserLocalizationUseCase,
    private val analytics: FirebaseAnalyticsDataSource,
    private val crashlytics: FirebaseCrashlyticsDataSource
) : ViewModel() {

    private val _userLocalization = MutableStateFlow<Localization?>(null)
    val userLocalization: StateFlow<Localization?> get() = _userLocalization

    private val _mapState = MutableStateFlow<HomeState>(HomeState.Empty)
    val mapState: StateFlow<HomeState> get() = _mapState

    fun getUserLocalization(email: String) {
        viewModelScope.launch {
            getUserLocalizationUseCase.execute(email)
                .onStart {
                    _mapState.value = HomeState.Loading
                    analytics.logEvent(
                        "get_user_localization_started",
                        mapOf("email" to email)
                    )

                }
                .catch { error ->
                    _mapState.value = HomeState.Error(error)
                    crashlytics.log("Get user localization error for email: $email")
                    crashlytics.recordException(error)
                }
                .collect { localization ->
                    _userLocalization.value = localization
                    _mapState.value = HomeState.DisplayMap(localization)
                    analytics.logEvent(
                        "get_user_localization_success", mapOf(
                            "email" to email,
                            "latitude" to (localization?.latitude ?: 0.0),
                            "longitude" to (localization?.longitude ?: 0.0)
                        )
                    )
                }
        }
    }

    fun insertOrUpdateUserLocalization(email: String, latitude: Double, longitude: Double) {
        viewModelScope.launch {
            val localization = Localization(email, latitude, longitude)
            _userLocalization.value = localization
            insertOrUpdateUserLocalizationUseCase.execute(localization)
            analytics.logEvent(
                "insert_or_update_user_localization", mapOf(
                    "email" to email,
                    "latitude" to latitude,
                    "longitude" to longitude
                )
            )
        }
    }

    fun clearComposable() {
        _mapState.value = HomeState.Empty
    }

    fun setError(message: Throwable) {
        _mapState.value = HomeState.Error(message)
        crashlytics.log("Home error: ${message.localizedMessage}")
        crashlytics.recordException(message)
    }
}
