import 'package:flutter/material.dart';

import 'src/presentation/pages/home_page.dart';
import 'src/presentation/pages/signin_page.dart';

class RouteGenerator {
  static Route<dynamic> generatorRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => const SigninPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        _erroRoute();
        return _erroRoute();
    }
  }

  static Route<dynamic> _erroRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(child: Text('Error')),
        );
      },
    );
  }
}
