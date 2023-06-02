package com.dacruz.bycodersmobile.home.di

import com.dacruz.bycodersmobile.home.data.local.HomeLocalDataSource
import com.dacruz.bycodersmobile.home.data.local.HomeLocalDataSourceImpl
import com.dacruz.bycodersmobile.home.data.mapper.LocalizationMapper
import com.dacruz.bycodersmobile.home.data.repository.UserLocalizationRepositoryImpl
import com.dacruz.bycodersmobile.home.domain.UserLocalizationRepository
import com.dacruz.bycodersmobile.home.domain.usecase.GetUserLocalizationUseCase
import com.dacruz.bycodersmobile.home.domain.usecase.InsertOrUpdateUserLocalizationUseCase
import com.dacruz.bycodersmobile.home.domain.usecase.impl.GetUserLocalizationUseCaseImpl
import com.dacruz.bycodersmobile.home.domain.usecase.impl.InsertOrUpdateUserLocalizationUseCaseImpl
import com.dacruz.bycodersmobile.home.presentation.HomeViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.core.module.Module
import org.koin.dsl.module


val homeModule: Module = module {

    single { LocalizationMapper() }

    single<UserLocalizationRepository> { UserLocalizationRepositoryImpl(get(), get()) }
    single<HomeLocalDataSource> { HomeLocalDataSourceImpl(get()) }


    // Use Cases
    factory<InsertOrUpdateUserLocalizationUseCase> { InsertOrUpdateUserLocalizationUseCaseImpl(get()) }
    factory<GetUserLocalizationUseCase> { GetUserLocalizationUseCaseImpl(get()) }


    // ViewModel
    viewModel { HomeViewModel(get(), get(), get(), get()) }
}
