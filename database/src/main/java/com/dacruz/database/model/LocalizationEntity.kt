package com.dacruz.database.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class LocalizationEntity(
    @PrimaryKey(autoGenerate = true)
    var id: Int = 0,
    val email: String,
    val latitude: Double,
    val longitude: Double
)
