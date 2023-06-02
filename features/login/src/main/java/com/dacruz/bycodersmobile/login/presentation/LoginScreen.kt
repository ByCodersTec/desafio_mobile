package com.dacruz.bycodersmobile.login.presentation

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Scaffold
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.dacruz.navigator.NavigationHandler
import com.dacruz.navigator.Screen
import com.dacruz.theme.components.DefaultToolbar
import com.dacruz.theme.components.LoadingButton
import com.dacruz.theme.components.WithErrorHandling
import kotlinx.coroutines.delay
import org.koin.androidx.compose.getViewModel

@Composable
fun LoginScreen(navigationHandler: NavigationHandler) {
    val loginViewModel: LoginViewModel = getViewModel()

    var shouldResetLoginScreen by remember { mutableStateOf(false) }

    val loginState by loginViewModel.loginState.collectAsState()

    if (shouldResetLoginScreen) {
        shouldResetLoginScreen = false
        loginViewModel.clearComposable()
    }

    Scaffold(
        topBar = {
            DefaultToolbar(
                title = "Login",
                shouldShowNavigationIcon = false
            )
        }
    ) {
        it
        LoginScreenContent(
            loginState = loginState,
            onLoginClick = { email, password ->
                loginViewModel.login(email, password)
            },
            navigationHandler = navigationHandler,
            clearError = {
                loginViewModel.clearComposable()
                shouldResetLoginScreen = true
            },
            loginViewModel = loginViewModel,
        )
    }
}


@Composable
private fun LoginScreenContent(
    loginState: LoginState,
    onLoginClick: (String, String) -> Unit,
    navigationHandler: NavigationHandler,
    clearError: () -> Unit,
    loginViewModel: LoginViewModel,
) {
    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center,
    ) {
        when (loginState) {
            is LoginState.Loading -> {
                CircularProgressIndicator(
                    color = MaterialTheme.colors.onSurface
                )
            }

            is LoginState.Success -> {
                Box(modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp), // Defina o valor do padding que você deseja aqui.
                    contentAlignment = Alignment.Center
                ) {
                    Text(
                        text = "Bem vindo(a), ${loginState.user.name}!, você foi autenticado com FirebaseAuth",
                        textAlign = TextAlign.Center, // Isto deve centralizar o texto.
                        modifier = Modifier.fillMaxWidth() // Isto deve fazer com que o Text preencha toda a largura disponível.
                    )
                }

                LaunchedEffect(key1 = Unit) {
                    delay(3000L)
                    clearError()
                    navigationHandler.navigateTo(
                        Screen.HomeScreen,
                        extra = loginState.user.email,
                    )
                }
            }

            is LoginState.Error -> {
                WithErrorHandling(
                    errorMessage = loginState.error.localizedMessage,
                    retryAction = clearError
                )
            }

            is LoginState.Empty -> {
                EmailPasswordForm(onLoginClick, navigationHandler, loginViewModel)
            }
        }
    }
}

@Composable
fun EmailPasswordForm(
    onLoginClick: (String, String) -> Unit,
    navigationHandler: NavigationHandler?,
    loginViewModel: LoginViewModel?,
) {
    var email by rememberSaveable { mutableStateOf("") }
    var password by rememberSaveable { mutableStateOf("") }
    var errorMessage by remember { mutableStateOf("") }
    var emailIsValid by remember { mutableStateOf(true) }

    LaunchedEffect(loginViewModel) {
        loginViewModel?.getUser()?.collect { user ->
            email = user?.email.toString()
        }
    }

    LaunchedEffect(email) {
        emailIsValid =
            email.isEmpty() || android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches()
    }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp)
    ) {
        TextField(
            value = email,
            onValueChange = { email = it },
            label = { Text("Email") },
            singleLine = true,
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 8.dp)
                .testTag("EmailTextField")
        )
        if (!emailIsValid && email.isNotEmpty()) {
            Text(
                text = "Invalid email address",
                color = MaterialTheme.colors.error,
                modifier = Modifier
                    .padding(bottom = 8.dp)
                    .testTag("InvalidEmailText")
            )
        }
        TextField(
            value = password,
            onValueChange = { password = it },
            label = { Text("Password") },
            singleLine = true,
            visualTransformation = PasswordVisualTransformation(),
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 8.dp)
                .testTag("PasswordTextField")
        )
        if (errorMessage.isNotEmpty()) {
            Text(
                text = errorMessage,
                color = MaterialTheme.colors.error,
                modifier = Modifier
                    .padding(bottom = 8.dp)
                    .testTag("ErrorMessage")

            )
        }
        LoadingButton(
            onClick = {
                if (email.isEmpty() || password.isEmpty()) {
                    errorMessage = "Please enter both email and password"
                } else if (!emailIsValid) {
                    errorMessage = "Please enter a valid email address"
                } else {
                    errorMessage = ""
                    onLoginClick(email, password)
                }
            },
            text = "Login com email pelo firebase",
            modifier = Modifier
                .fillMaxWidth()
                .testTag("LoginButton")

        )

        Button(
            onClick = { navigationHandler?.navigateTo(Screen.RegisterScreen) },
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 8.dp)
                .testTag("RegisterButton")
        ) {
            Text("Cadastre-se no firebase")
        }
    }
}
