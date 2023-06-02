package com.dacruz.theme.components

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.width
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.Text
import androidx.compose.material.TopAppBar
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.ArrowBack
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp

@Composable
fun DefaultToolbar(
    title: String = "",
    onUpPress: () -> Unit = {},
    modifier: Modifier = Modifier,
    shouldShowNavigationIcon: Boolean = true,
    alternativeIcon: ImageVector? = null
) {
    TopAppBar(
        title = {
            Box(modifier = Modifier.fillMaxSize()) {
                Text(
                    text = title,
                    modifier = when {
                        alternativeIcon != null || shouldShowNavigationIcon -> Modifier.align(
                            Alignment.CenterStart
                        )

                        else -> Modifier.align(Alignment.Center)
                    },
                )
            }
        },
        navigationIcon = {
            if (alternativeIcon != null || shouldShowNavigationIcon) {
                IconButton(onClick = onUpPress) {
                    Icon(
                        imageVector = alternativeIcon ?: Icons.Rounded.ArrowBack,
                        contentDescription = "",
                    )
                }
            } else {
                Box(Modifier.width(72.dp)) {}
            }
        },
        actions = {
            Box(Modifier.width(72.dp)) {}
        },
        modifier = modifier,
    )
}
