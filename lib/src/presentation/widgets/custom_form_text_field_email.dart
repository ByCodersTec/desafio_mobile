import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'custom_form_text_field.dart';

class CustomFormTextFieldEmail extends StatelessWidget {
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

  const CustomFormTextFieldEmail({
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
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormTextField(
      name: name,
      label: label,
      hint: hint,
      enabled: enabled,
      prefixIcon: hasPrefixIcon ? const Icon(Icons.alternate_email) : null,
      helperText: helperText,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      validators: [
        ...validators,
        FormBuilderValidators.email(
          errorText: 'Email inválido',
        ),
      ],
      autovalidateMode: autovalidateMode,
    );
  }
}
