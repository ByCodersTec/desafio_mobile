import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme(
        primary: Colors.orange,
        onPrimary: Colors.white,
        primaryVariant: Colors.redAccent,
        background: Colors.blueAccent,
        onBackground: Colors.white,
        secondary: Colors.deepPurpleAccent,
        onSecondary: Colors.white,
        secondaryVariant: Colors.deepOrange,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        brightness: Brightness.light,
      ),
    );
