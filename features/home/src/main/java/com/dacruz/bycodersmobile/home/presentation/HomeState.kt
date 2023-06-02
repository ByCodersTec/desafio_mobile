package com.dacruz.bycodersmobile.home.presentation

import com.dacruz.bycodersmobile.home.domain.model.Localization

sealed class HomeState {
    object Empty : HomeState()
    object Loading : HomeState()
    data class DisplayMap(val location: Localization?) : HomeState()
    data class Error(val error: Throwable) : HomeState()
}
