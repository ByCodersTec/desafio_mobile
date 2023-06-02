package com.dacruz.bycodersmobile.login.presentation

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
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
import androidx.compose.ui.unit.dp
import com.dacruz.navigator.NavigationHandler
import com.dacruz.navigator.Screen
import com.dacruz.theme.components.DefaultToolbar
import com.dacruz.theme.components.LoadingButton
import com.dacruz.theme.components.WithErrorHandling
import kotlinx.coroutines.delay
import org.koin.androidx.compose.getViewModel

@Composable
fun RegisterScreen(navigationHandler: NavigationHandler) {
    val loginViewModel: LoginViewModel = getViewModel()

    var shouldResetRegisterScreen by remember { mutableStateOf(false) }

    val loginState by loginViewModel.loginState.collectAsState()

    if (shouldResetRegisterScreen) {
        shouldResetRegisterScreen = false
        loginViewModel.clearComposable()
    }

    Scaffold(
        topBar = {
            DefaultToolbar(
                title = "Register",
                shouldShowNavigationIcon = true,
                onUpPress = { navigationHandler.navigateBack() }
            )
        }
    ) {
        it
        RegisterScreenContent(
            loginState = loginState,
            onRegisterClick = { email, password, name ->
                loginViewModel.register(email, password, name)
            },
            navigationHandler = navigationHandler,
            clearError = {
                loginViewModel.clearComposable()
                shouldResetRegisterScreen = true
            }
        )
    }
}

@Composable
private fun RegisterScreenContent(
    loginState: LoginState,
    onRegisterClick: (String, String, String) -> Unit,
    navigationHandler: NavigationHandler,
    clearError: () -> Unit
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
                Text(text = "Bem vindo(a), ${loginState.user.name}! Você foi registrado(a) com o FirebaseAuth")
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
                RegisterForm(onRegisterClick)
            }
        }
    }
}



@Composable
fun RegisterForm(
    onRegisterClick: (String, String, String) -> Unit
) {
    var name by rememberSaveable { mutableStateOf("") }
    var email by rememberSaveable { mutableStateOf("") }
    var password by rememberSaveable { mutableStateOf("") }
    var errorMessage by remember { mutableStateOf("") }
    var emailIsValid by remember { mutableStateOf(true) }

    LaunchedEffect(email) {
        delay(1000L)
        emailIsValid =
            email.isEmpty() || android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches()
    }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp)
    ) {
        TextField(
            value = name,
            onValueChange = { name = it },
            label = { Text("Name") },
            singleLine = true,
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 8.dp)
                .testTag("NameTextField")
        )
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
                if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
                    errorMessage = "Please enter name, email and password"
                } else if (!emailIsValid) {
                    errorMessage = "Please enter a valid email address"
                } else {
                    errorMessage = ""
                    onRegisterClick(email, password, name)
                }
            },
            text = "Register",
            modifier = Modifier
                .fillMaxWidth()
                .testTag("RegisterButton")
        )
    }
}
