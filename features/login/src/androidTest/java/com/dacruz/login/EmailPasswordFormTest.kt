package com.dacruz.login

import androidx.compose.ui.test.ExperimentalTestApi
import androidx.compose.ui.test.assertIsDisplayed
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performTextInput
import androidx.test.filters.MediumTest
import com.dacruz.bycodersmobile.login.presentation.EmailPasswordForm
import kotlinx.coroutines.async
import kotlinx.coroutines.delay
import kotlinx.coroutines.test.runTest
import org.junit.Rule
import org.junit.Test

@MediumTest
@ExperimentalTestApi
class EmailPasswordFormTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    private fun performTextInputWithDelay(nodeTag: String, text: String, delayMillis: Long) {
        for (char in text) {
            composeTestRule
                .onNodeWithTag(nodeTag)
                .performTextInput(char.toString())
            runTest {
                this.async {
                    delay(delayMillis)
                }
            }
        }
    }

    @Test
    fun whenEmailIsValid_doNotShowInvalidEmailError() {
        // Arrange
        composeTestRule.setContent {
            EmailPasswordForm(
                navigationHandler = null,
                loginViewModel = null,
                onLoginClick = { _, _ -> })
        }

        // Act
        performTextInputWithDelay("EmailTextField", "test@test.com", 300)

        composeTestRule
            .onNodeWithText("Login com email pelo firebase")
            .performClick()

        // Assert
        composeTestRule
            .onNodeWithText("Invalid email address")
            .assertDoesNotExist()
    }

    @Test
    fun whenEmailIsEmpty_showInvalidEmailError() {
        // Arrange
        composeTestRule.setContent {
            EmailPasswordForm(
                navigationHandler = null,
                loginViewModel = null,
                onLoginClick = { _, _ -> })
        }

        // Act & Assert
        composeTestRule
            .onNodeWithTag("InvalidEmailText")
            .assertDoesNotExist()

        performTextInputWithDelay("EmailTextField", "", 300)

        composeTestRule
            .onNodeWithText("Login com email pelo firebase")
            .performClick()

        composeTestRule
            .onNodeWithTag("InvalidEmailText")
            .assertDoesNotExist()
    }


    @Test
    fun whenInvalidEmailIsEntered_showErrorMessage() {
        // Arrange
        composeTestRule.setContent {
            EmailPasswordForm(
                navigationHandler = null,
                loginViewModel = null,
                onLoginClick = { _, _ -> })
        }

        // Act
        performTextInputWithDelay("EmailTextField", "invalid-email", 2000)

        composeTestRule
            .onNodeWithTag("LoginButton")
            .performClick()

        // Assert
        composeTestRule
            .onNodeWithTag("InvalidEmailText")
            .assertIsDisplayed()
    }
}
