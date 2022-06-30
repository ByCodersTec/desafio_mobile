import 'package:desafio_mobile/src/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'src/presentation/pages/home_page.dart';
import 'src/presentation/pages/signin_page.dart';

class RouteGenerator {
  static Route<dynamic> generatorRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => const SigninPage());
      case '/home':
        if ((args! as List)[0] is User) {
          if ((args as List)[1] is LatLng) {
            return MaterialPageRoute(
              builder: (context) => HomePage(
                user: (args)[0],
                position: args[1],
              ),
            );
          }
        }
        return _erroRoute();
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
