import 'package:desafio_mobile/config/fluterfire/flutterfire_init.dart';
import 'package:flutter/material.dart';
import 'package:desafio_mobile/core/common/injected/module.dart';

Future<void> main() async {
  await configureInjection();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FlutterFireInit());
}
