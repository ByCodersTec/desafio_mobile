package com.dacruz.networking

import com.dacruz.networking.errors.ConnectionTimeoutTransformer
import com.dacruz.networking.errors.HttpNotFoundTransformer
import com.dacruz.networking.errors.ExceptionTransformerImpl

val transformerList = mutableListOf<ExceptionTransformer>(
    ConnectionTimeoutTransformer(),
    HttpNotFoundTransformer()
)

val transformer = ExceptionTransformerImpl(transformerList)

suspend fun <T> executeRequest(
    request: suspend () -> T
): T {
    return try {
        request()
    } catch (incoming: Throwable) {
        throw transformer.transform(incoming)
    }
}

fun addTransformers(vararg transformers: ExceptionTransformer) {
    transformerList.addAll(transformers.toList())
}
