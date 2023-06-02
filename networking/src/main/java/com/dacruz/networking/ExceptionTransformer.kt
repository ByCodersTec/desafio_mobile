package com.dacruz.networking

interface ExceptionTransformer {
    val next: ExceptionTransformer?
    fun transform(incoming: Throwable): Throwable
}
