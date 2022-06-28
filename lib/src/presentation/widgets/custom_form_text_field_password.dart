import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'custom_form_text_field.dart';

class CustomFormTextFieldPassword extends StatefulWidget {
  final String name;
  final String label;
  final String hint;
  final bool enabled;
  final String? helperText;
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final List<FormFieldValidator<String>> validators;
  final AutovalidateMode autovalidateMode;
  final bool hasPrefixIcon;
  final bool hasShowHidePasswordIcon;

  const CustomFormTextFieldPassword({
    Key? key,
    required this.name,
    required this.label,
    required this.hint,
    this.enabled = true,
    this.helperText,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.validators = const [],
    this.autovalidateMode = AutovalidateMode.disabled,
    this.hasPrefixIcon = false,
    this.hasShowHidePasswordIcon = true,
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  State<CustomFormTextFieldPassword> createState() => _CustomFormTextFieldPasswordState();
}

class _CustomFormTextFieldPasswordState extends State<CustomFormTextFieldPassword> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomFormTextField(
      name: widget.name,
      label: widget.label,
      hint: widget.hint,
      enabled: widget.enabled,
      prefixIcon: widget.hasPrefixIcon
          ? const Icon(
              IconData(
                61572,
                fontFamily: 'FontAwesomeSolid',
                fontPackage: 'font_awesome_flutter',
              ),
            )
          : null,
      suffixIcon: widget.hasShowHidePasswordIcon
          ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            )
          : null,
      helperText: widget.helperText,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      validators: [
        ...widget.validators,
        FormBuilderValidators.minLength(
          6,
          errorText: 'Deve conter no mínimo 6 caracteres',
        ),
      ],
      autovalidateMode: widget.autovalidateMode,
    );
  }
}
