package com.dacruz.theme

import androidx.compose.material.Text
import androidx.compose.ui.test.ExperimentalTestApi
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithText
import com.dacruz.theme.components.ErrorWithRetry
import com.dacruz.theme.components.WithErrorHandling
import org.junit.Rule
import org.junit.Test

@ExperimentalTestApi
class ErrorComponentsTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun errorWithRetry_shouldDisplayErrorMessageAndRetryButton() {
        // Arrange
        composeTestRule.setContent {
            ErrorWithRetry(
                errorMessage = "An error occurred",
                onRetryClick = {}
            )
        }

        // Act & Assert
        composeTestRule.onNodeWithText("An error occurred").assertExists()
        composeTestRule.onNodeWithText("Tentar novamente").assertExists()
    }

    @Test
    fun withErrorHandling_withErrorMessage_shouldDisplayErrorComponent() {
        // Arrange
        val errorMessage = "An error occurred"

        composeTestRule.setContent {
            WithErrorHandling(
                errorMessage = errorMessage,
                retryAction = {},
                content = {
                    Text(text = "Content")
                }
            )
        }

        // Act & Assert
        composeTestRule.onNodeWithText("Content").assertExists()
        composeTestRule.onNodeWithText(errorMessage).assertExists()
        composeTestRule.onNodeWithText("Tentar novamente").assertExists()
    }

    @Test
    fun withErrorHandling_withoutErrorMessage_shouldNotDisplayErrorComponent() {
        // Arrange
        val errorMessage: String? = null

        composeTestRule.setContent {
            WithErrorHandling(
                errorMessage = errorMessage,
                retryAction = {},
                content = {
                    Text(text = "Content")
                }
            )
        }

        // Act & Assert
        composeTestRule.onNodeWithText("Content").assertExists()
        composeTestRule.onNodeWithText("Tentar novamente").assertDoesNotExist()
    }
}
