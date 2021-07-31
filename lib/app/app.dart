import 'package:desafio_mobile/app/login/ui/login_page.dart';
import 'package:desafio_mobile/config/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:desafio_mobile/app/home/ui/pages/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoutes,
      theme: lightTheme,
      initialRoute: '/login',
    );
  }
}

Route generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => HomePage());
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginPage());
    default:
      return MaterialPageRoute(builder: (_) => LoginPage());
  }
}
