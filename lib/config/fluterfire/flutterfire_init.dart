import 'package:desafio_mobile/app/app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

class FlutterFireInit extends StatefulWidget {
  _FlutterFireInitState createState() => _FlutterFireInitState();
}

class _FlutterFireInitState extends State<FlutterFireInit> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();

      setState(() {
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        _initialized = true;
      });
    } catch (e) {
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
    if (_error) {
      return Container(
        color: Colors.red,
      );
    }

    if (!_initialized) {
      return Container(
        color: Colors.white,
      );
    }

    return MyApp();
  }
}
