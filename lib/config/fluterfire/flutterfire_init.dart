import 'package:desafio_mobile/app/app.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

class FlutterFireInit extends StatefulWidget {
  _FlutterFireInitState createState() => _FlutterFireInitState();
}

class _FlutterFireInitState extends State<FlutterFireInit> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();

      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Container(
        color: Colors.red,
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
      );
    }

    return MyApp();
  }
}
