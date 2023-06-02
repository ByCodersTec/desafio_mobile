package com.dacruz.database.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class UserEntity(
    @PrimaryKey val email: String,
    val name: String,
    var lastLogin: Long? = null
)
