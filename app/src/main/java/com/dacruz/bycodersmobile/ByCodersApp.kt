package com.dacruz.bycodersmobile

import android.app.Application
import com.dacruz.bycodersmobile.firebase.di.firebaseModule
import com.dacruz.bycodersmobile.home.di.homeModule
import com.dacruz.bycodersmobile.login.di.loginModule
import com.dacruz.database.di.databaseModule
import com.dacruz.navigator.di.navigationModule
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.GlobalContext.startKoin
import org.koin.core.logger.Level

class ByCodersApp : Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidLogger(Level.DEBUG)
            androidContext(this@ByCodersApp)
            modules(
                listOf(
                    firebaseModule,
                    databaseModule,
                    navigationModule,
                    loginModule,
                    homeModule
                )
            )
        }
    }
}
