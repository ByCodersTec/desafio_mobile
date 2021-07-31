import 'package:flutter/material.dart';

Widget buildProgressIndicator({
  Alignment? aligment,
  double? containerHeight,
}) =>
    Center(
      child: Container(
        height: containerHeight ?? 120.0,
        width: 120.0,
        child: Align(
          alignment: aligment ?? Alignment.center,
          child: const CircularProgressIndicator(
            backgroundColor: Colors.orange,
            strokeWidth: 3,
          ),
        ),
      ),
    );
