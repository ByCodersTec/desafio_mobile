package com.dacruz.bycodersmobile.login.di

import com.dacruz.bycodersmobile.login.data.local.UserLocalDataSource
import com.dacruz.bycodersmobile.login.data.local.UserLocalDataSourceImpl
import com.dacruz.bycodersmobile.login.data.mapper.UserMapper
import com.dacruz.bycodersmobile.login.data.repository.LoginRepositoryImpl
import com.dacruz.bycodersmobile.login.domain.GetUserUseCase
import com.dacruz.bycodersmobile.login.domain.LoginRepository
import com.dacruz.bycodersmobile.login.domain.LoginUseCase
import com.dacruz.bycodersmobile.login.domain.RegisterUseCase
import com.dacruz.bycodersmobile.login.domain.SaveUserUseCase
import com.dacruz.bycodersmobile.login.domain.usecase.GetUserUseCaseImpl
import com.dacruz.bycodersmobile.login.domain.usecase.LoginUseCaseImpl
import com.dacruz.bycodersmobile.login.domain.usecase.RegisterUseCaseImpl
import com.dacruz.bycodersmobile.login.domain.usecase.SaveUserUseCaseImpl
import com.dacruz.bycodersmobile.login.presentation.LoginViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val loginModule = module {

    single<LoginRepository> {
        LoginRepositoryImpl(
            firebaseAuthService = get(),
            localDataSource = get(),
            userMapper = get()
        )
    }

    single { UserMapper() }

    single<UserLocalDataSource> { UserLocalDataSourceImpl(userDao = get()) }

    single<LoginUseCase> { LoginUseCaseImpl(loginRepository = get()) }
    single<SaveUserUseCase> { SaveUserUseCaseImpl(loginRepository = get()) }
    single<RegisterUseCase> { RegisterUseCaseImpl(loginRepository = get()) }
    single<GetUserUseCase> { GetUserUseCaseImpl(loginRepository = get()) }

    viewModel {
        LoginViewModel(
            loginUseCase = get(),
            saveUserUseCase = get(),
            registerUseCase = get(),
            getUserUseCase = get(),
            analytics = get(),
            crashlytics = get()
        )
    }
}
