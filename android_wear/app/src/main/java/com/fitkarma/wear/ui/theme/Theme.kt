package com.fitkarma.wear.ui.theme

import androidx.compose.ui.graphics.Color
import androidx.wear.compose.material.MaterialTheme

val Primary = Color(0xFF4CAF50)
val PrimaryVariant = Color(0xFF388E3C)
val Secondary = Color(0xFF03DAC6)
val SecondaryVariant = Color(0xFF018786)

val Background = Color(0xFF121212)
val Surface = Color(0xFF1E1E1E)
val Error = Color(0xFFCF6679)

val OnPrimary = Color.White
val OnSecondary = Color.Black
val OnBackground = Color.White
val OnSurface = Color.White
val OnError = Color.Black

val FitkarmaWearTheme = androidx.compose.material3.MaterialTheme(
    colorScheme = androidx.compose.material3.MaterialTheme.colorScheme.copy(
        primary = Primary,
        secondary = Secondary,
        background = Background,
        surface = Surface,
        error = Error,
        onPrimary = OnPrimary,
        onSecondary = OnSecondary,
        onBackground = OnBackground,
        onSurface = OnSurface,
        onError = OnError
    ),
    typography = androidx.compose.material3.MaterialTheme.typography,
    shapes = androidx.compose.material3.MaterialTheme.shapes
)
