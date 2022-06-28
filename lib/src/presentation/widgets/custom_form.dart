import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomForm extends StatefulWidget {
  final Function(BuildContext, Map<String, dynamic> Function()) builder;
  final AutovalidateMode autovalidateMode;

  const CustomForm({
    Key? key,
    required this.builder,
    required this.autovalidateMode,
  }) : super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> getValidatedFormState() {
    bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
    var formFields = _formKey.currentState?.fields ?? {};

    Map<String, dynamic> mappedFormFields = {'isValid': isValid};

    formFields.forEach((key, value) {
      mappedFormFields[key] = value.value;
    });

    return mappedFormFields;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: widget.autovalidateMode,
      child: widget.builder(context, getValidatedFormState),
    );
  }
}
