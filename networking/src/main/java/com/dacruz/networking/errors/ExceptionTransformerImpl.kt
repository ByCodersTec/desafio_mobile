package com.dacruz.networking.errors

import com.dacruz.networking.ExceptionTransformer
import retrofit2.HttpException
import java.net.SocketTimeoutException
import java.net.http.HttpTimeoutException

class ConnectionTimeoutTransformer(override val next: ExceptionTransformer? = null) : ExceptionTransformer {
    override fun transform(incoming: Throwable): Throwable {
        return if (incoming is SocketTimeoutException) {
            HttpTimeoutException("A conexão expirou.")
        } else {
            next?.transform(incoming) ?: incoming
        }
    }
}

class HttpNotFoundException(override val message: String) : RuntimeException(message)

class HttpNotFoundTransformer(override val next: ExceptionTransformer? = null) : ExceptionTransformer {
    override fun transform(incoming: Throwable): Throwable {
        return if (incoming is HttpException && incoming.code() == 404) {
            HttpNotFoundException("Recurso não encontrado.")
        } else {
            next?.transform(incoming) ?: incoming
        }
    }
}

class ExceptionTransformerImpl(private val transformers: List<ExceptionTransformer>) : ExceptionTransformer {

    override val next: ExceptionTransformer? = null

    override fun transform(incoming: Throwable): Throwable {
        transformers.forEach { transformer ->
            val result = transformer.transform(incoming)
            if (result !== incoming) {
                return result
            }
        }
        return incoming
    }
}
