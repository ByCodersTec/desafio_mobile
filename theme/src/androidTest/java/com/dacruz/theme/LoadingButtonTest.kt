package com.dacruz.theme

import androidx.compose.ui.test.ExperimentalTestApi
import androidx.compose.ui.test.assertIsDisplayed
import androidx.compose.ui.test.assertIsNotEnabled
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import com.dacruz.theme.components.LoadingButton
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Rule
import org.junit.Test


@ExperimentalCoroutinesApi
@ExperimentalTestApi
class LoadingButtonTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun loadingButton_whenNotLoading_shouldDisplayText() {
        // Arrange
        val buttonText = "Click Me"
        val onClick: () -> Unit = {}

        composeTestRule.setContent {
            LoadingButton(onClick = onClick, text = buttonText)
        }

        // Act & Assert
        composeTestRule.onNodeWithText(buttonText).assertIsDisplayed()
        composeTestRule.onNodeWithTag("CircularProgressIndicator").assertDoesNotExist()
    }

    @Test
    fun loadingButton_whenLoading_shouldDisplayProgressBar() {
        // Arrange
        val buttonText = "Click Me"
        val onClick: () -> Unit = {}

        composeTestRule.setContent {
            LoadingButton(onClick = onClick, text = buttonText)
        }

        // Act
        runTest {
            composeTestRule.onNodeWithText(buttonText).performClick()
            advanceUntilIdle()
        }

        // Assert
        composeTestRule.onNodeWithText(buttonText).assertIsDisplayed()
        composeTestRule.onNodeWithTag("CircularProgressIndicator").assertIsDisplayed()
    }

    @Test
    fun loadingButton_whenLoading_shouldDisableClicks() {
        // Arrange
        val buttonText = "Click Me"
        val onClick: () -> Unit = {}

        composeTestRule.setContent {
            LoadingButton(onClick = onClick, text = buttonText)
        }

        // Act
        runTest {
            composeTestRule.onNodeWithText(buttonText).performClick()
            advanceUntilIdle()
        }

        // Assert
        composeTestRule.onNodeWithText(buttonText).assertIsNotEnabled()
    }
}
