import 'package:desafio_mobile/config/ui/theme/fonts.dart';
import 'package:flutter/material.dart';

class CustomFieldText extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final bool isPassword;
  final bool isEmail;

  CustomFieldText({
    required this.controller,
    required this.label,
    this.inputType = TextInputType.text,
    this.isPassword = false,
    this.isEmail = false,
  });

  static final fontDescriptionStyle = TextStyle(
    fontFamily: AppFonts.family,
    height: 1.4,
    fontSize: 14.0,
    color: Color.fromRGBO(38, 38, 38, 0.35),
    fontWeight: FontWeight.w900,
  );

  static InputDecoration inputDecoration(label,
          {prefix, sufix, fontDescriptionStyle}) =>
      InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(38, 38, 38, 0.06),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        hintStyle: fontDescriptionStyle,
        hintText: label,
        contentPadding: EdgeInsets.only(left: 15),
        fillColor: Color.fromRGBO(38, 38, 38, 0.06),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromRGBO(38, 38, 38, 0.06), width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Insira algum texto';
          }

          final regExpEmail = RegExp(
              r'(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))');
          if (isEmail && !regExpEmail.hasMatch(value)) {
            return 'Insira um email válido';
          }

          return null;
        },
        keyboardType: inputType,
        cursorColor: Colors.grey,
        decoration: inputDecoration(
          label,
          fontDescriptionStyle: fontDescriptionStyle,
        ),
      ),
    );
  }
}
