package com.dacruz.theme

import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.Text
import androidx.compose.material.TopAppBar
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.Icons.Filled
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Menu
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.test.ExperimentalTestApi
import androidx.compose.ui.test.assert
import androidx.compose.ui.test.hasClickAction
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithContentDescription
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.text.style.TextAlign
import org.junit.Rule
import org.junit.Test

@ExperimentalTestApi
class DefaultToolbarTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun defaultToolbar_withTitleAndNavigationIcon_shouldDisplayCorrectly() {
        // Arrange
        composeTestRule.setContent {
            DefaultToolbar(
                title = "My Title",
                onUpPress = {},
                shouldShowNavigationIcon = true
            )
        }

        // Act & Assert
        composeTestRule.onNodeWithText("My Title").assertExists()
        composeTestRule.onNodeWithTag("NavigationIcon").assertExists()
    }

    @Test
    fun defaultToolbar_withTitleAndAlternativeIcon_shouldDisplayCorrectly() {
        // Arrange
        composeTestRule.setContent {
            DefaultToolbar(
                title = "My Title",
                onUpPress = {},
                alternativeIcon = Filled.Menu
            )
        }

        // Act & Assert
        composeTestRule.onNodeWithText("My Title").assertExists()
        composeTestRule.onNodeWithContentDescription("").assert(hasClickAction())
    }

    @Test
    fun defaultToolbar_withoutNavigationIcon_shouldNotDisplayNavigationIcon() {
        // Arrange
        composeTestRule.setContent {
            DefaultToolbar(
                title = "My Title",
                onUpPress = {},
                shouldShowNavigationIcon = false
            )
        }

        // Act & Assert
        composeTestRule.onNodeWithText("My Title").assertExists()
        composeTestRule.onNodeWithTag("NavigationIcon").assertDoesNotExist()
    }
}

@Composable
fun DefaultToolbar(
    title: String = "",
    textAlign: TextAlign = TextAlign.Start,
    onUpPress: () -> Unit = {},
    modifier: Modifier = Modifier,
    shouldShowNavigationIcon: Boolean = true,
    alternativeIcon: ImageVector? = null
) {
    TopAppBar(
        title = {
            Text(
                text = title,
                textAlign = textAlign,
            )
        },
        navigationIcon = {
            if (alternativeIcon != null || shouldShowNavigationIcon) {
                IconButton(
                    onClick = onUpPress,
                    modifier = Modifier.testTag("NavigationIcon")
                ) {
                    Icon(
                        imageVector = alternativeIcon ?: Icons.Default.ArrowBack,
                        contentDescription = ""
                    )
                }
            }
        },
        modifier = modifier,
    )
}
