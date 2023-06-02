package com.dacruz.bycodersmobile.login.data.mapper

import com.dacruz.database.model.UserEntity
import com.dacruz.bycodersmobile.firebase.data.model.User as FirebaseAuthUser
import com.dacruz.bycodersmobile.login.domain.model.User as DomainUser

class UserMapper {

    fun mapFirebaseUserToDomain(firebaseAuthUser: FirebaseAuthUser): DomainUser {
        return DomainUser(
            name = firebaseAuthUser.name,
            email = firebaseAuthUser.email
        )
    }

    fun mapDomainToEntity(user: DomainUser): UserEntity {
        return UserEntity(
            name = user.name.orEmpty(),
            email = user.email.orEmpty()
        )
    }

    fun mapEntityToDomain(user: UserEntity): DomainUser {
        return DomainUser(
            name = user.name,
            email = user.email
        )
    }
}
