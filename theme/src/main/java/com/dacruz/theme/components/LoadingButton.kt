package com.dacruz.theme.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

@Composable
fun LoadingButton(
    onClick: () -> Unit,
    text: String,
    modifier: Modifier = Modifier,
) {
    val coroutineScope = rememberCoroutineScope()
    var isLoading by remember { mutableStateOf(false) }

    fun performClick() {
        if (!isLoading) {
            isLoading = true
            coroutineScope.launch {
                delay(2000)
                onClick()
                isLoading = false
            }
        }
    }

    val buttonColors = ButtonDefaults.buttonColors(
        backgroundColor = if (isLoading) Color.Gray else MaterialTheme.colors.primary,
        contentColor = if (isLoading) Color.White else MaterialTheme.colors.onPrimary,
        disabledBackgroundColor = Color.Gray
    )

    Button(
        onClick = ::performClick,
        enabled = !isLoading,
        colors = buttonColors,
        modifier = modifier,
        shape = RectangleShape
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.Center
        ) {
            Text(text = text)

            if (isLoading) {
                CircularProgressIndicator(
                    color = MaterialTheme.colors.onPrimary,
                    modifier = Modifier
                        .size(30.dp)
                        .padding(start = 8.dp).testTag("CircularProgressIndicator"),
                    strokeWidth = 2.dp
                )
            }
        }
    }
}
