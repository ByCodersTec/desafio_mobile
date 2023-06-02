package com.dacruz.bycodersmobile.login.domain.model

data class User(
    val uid: String? = null,
    val name: String?,
    val email: String?,
    val latitude: Double? = null,
    val longitude: Double? = null
)
