package com.dacruz.bycodersmobile.firebase.errors

import com.dacruz.networking.ExceptionTransformer
import com.google.firebase.auth.FirebaseAuthInvalidCredentialsException
import com.google.firebase.auth.FirebaseAuthInvalidUserException
import com.google.firebase.auth.FirebaseAuthMultiFactorException
import com.google.firebase.auth.FirebaseAuthRecentLoginRequiredException
import com.google.firebase.auth.FirebaseAuthUserCollisionException
import com.google.firebase.auth.FirebaseAuthWebException

class FirebaseAuthInvalidCredentialsExceptionTransformer(override val next: ExceptionTransformer? = null) :
    ExceptionTransformer {
    override fun transform(incoming: Throwable): Throwable {
        return if (incoming is FirebaseAuthInvalidCredentialsException) {
            InvalidCredentialsException("As credenciais fornecidas são inválidas.")
        } else {
            next?.transform(incoming) ?: incoming
        }
    }

}

class InvalidCredentialsException(override val message: String) : RuntimeException(message)

class FirebaseAuthInvalidUserExceptionTransformer(override val next: ExceptionTransformer? = null) :
    ExceptionTransformer {
    override fun transform(incoming: Throwable): Throwable {
        return if (incoming is FirebaseAuthInvalidUserException) {
            InvalidUserException("Usuário inválido. Por favor, verifique suas informações.")
        } else {
            next?.transform(incoming) ?: incoming
        }
    }
}

class InvalidUserException(override val message: String) : RuntimeException(message)

class FirebaseAuthMultiFactorExceptionTransformer(override val next: ExceptionTransformer? = null) :
    ExceptionTransformer {
    override fun transform(incoming: Throwable): Throwable {
        return if (incoming is FirebaseAuthMultiFactorException) {
            MultiFactorException("Ocorreu um erro durante o processo de autenticação multifator.")
        } else {
            next?.transform(incoming) ?: incoming
        }
    }
}

class MultiFactorException(override val message: String) : RuntimeException(message)

class FirebaseAuthRecentLoginRequiredExceptionTransformer(override val next: ExceptionTransformer? = null) :
    ExceptionTransformer {
    override fun transform(incoming: Throwable): Throwable {
        return if (incoming is FirebaseAuthRecentLoginRequiredException) {
            RecentLoginRequiredException("É necessário fazer login novamente para concluir esta ação.")
        } else {
            next?.transform(incoming) ?: incoming
        }
    }
}

class RecentLoginRequiredException(override val message: String) : RuntimeException(message)

class FirebaseAuthUserCollisionExceptionTransformer(override val next: ExceptionTransformer? = null) :
    ExceptionTransformer {
    override fun transform(incoming: Throwable): Throwable {
        return if (incoming is FirebaseAuthUserCollisionException) {
            UserCollisionException("O usuário já existe ou houve uma colisão de usuários.")
        } else {
            next?.transform(incoming) ?: incoming
        }
    }
}

class UserCollisionException(override val message: String) : RuntimeException(message)

class FirebaseAuthWebExceptionTransformer(override val next: ExceptionTransformer? = null) :
    ExceptionTransformer {
    override fun transform(incoming: Throwable): Throwable {
        return if (incoming is FirebaseAuthWebException) {
            WebException("Ocorreu um erro durante a autenticação na web.")
        } else {
            next?.transform(incoming) ?: incoming
        }
    }
}

class WebException(override val message: String) : RuntimeException(message)
