import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ElevatedButton(
            onPressed: () {
              context.read<FirebaseCrashlytics>().crash();
            },
            child: const Text('Forcing a crash'))
      ]),
    );
  }
}
