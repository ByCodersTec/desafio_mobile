import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

part 'subwidgets/error_text_widget.dart';
part 'subwidgets/helper_text_widget.dart';

class CustomFormTextField extends StatefulWidget {
  final String name;
  final String label;
  final String hint;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? helperText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final List<FormFieldValidator<String>> validators;
  final AutovalidateMode autovalidateMode;
  final TextCapitalization textCapitalization;

  const CustomFormTextField({
    Key? key,
    required this.name,
    required this.label,
    required this.hint,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.validators = const [],
    this.autovalidateMode = AutovalidateMode.disabled,
    this.textCapitalization = TextCapitalization.none,
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  String? _errorText;
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _hasInteractedByUser = false;
  double _borderWidth = CustomFormTextFieldStyle.unfocusedBorderWidth;

  @override
  void initState() {
    super.initState();
    _initController();
    _focusNode.addListener(_onFocusChaged);
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    _focusNode.removeListener(_onFocusChaged);
    _focusNode.dispose();
    super.dispose();
  }

  void _initController() {
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  void _onFocusChaged() {
    setState(() {
      _updateBorderWidth();
    });
  }

  void _updateBorderWidth() {
    _borderWidth = _focusNode.hasFocus
        ? CustomFormTextFieldStyle.focusedBorderWidth
        : CustomFormTextFieldStyle.unfocusedBorderWidth;
  }

  void _validate() {
    final validators = widget.validators;
    for (final validator in validators) {
      _errorText = validator(_controller.text);
      if (_errorText != null) break;
    }
  }

  void _onChanged(String? text) {
    setState(() {
      _hasInteractedByUser = true;
    });
    widget.onChanged?.call(text);
  }

  void _onSaved(String? text) {
    setState(() {
      _validate();
    });
  }

  Color get _borderColor {
    final colorCode = _errorText != null
        ? CustomFormTextFieldStyle.errorColor
        : _focusNode.hasFocus
            ? CustomFormTextFieldStyle.focusedColor
            : CustomFormTextFieldStyle.defaultBorderColor;
    return Color(colorCode);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enabled) {
      switch (widget.autovalidateMode) {
        case AutovalidateMode.always:
          _validate();
          break;
        case AutovalidateMode.onUserInteraction:
          if (_hasInteractedByUser) _validate();
          break;
        case AutovalidateMode.disabled:
          break;
      }
    }
    final borderInternalPadding =
        CustomFormTextFieldStyle.maxBorderInternalSpaceUsed - _borderWidth;
    final themeData = Theme.of(context);
    return Theme(
      data: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(
          primary: const Color(CustomFormTextFieldStyle.focusedColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 56,
            padding: EdgeInsets.all(borderInternalPadding),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(
                color: _borderColor,
                width: _borderWidth,
              ),
            ),
            child: FormBuilderTextField(
              name: widget.name,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              controller: _controller,
              onChanged: _onChanged,
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: widget.hint,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                labelStyle: const TextStyle(
                  color: Color(CustomFormTextFieldStyle.labelColor),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorStyle: const TextStyle(height: 0, fontSize: 0),
              ),
              validator: FormBuilderValidators.compose(widget.validators),
              onSaved: _onSaved,
              textCapitalization: widget.textCapitalization,
            ),
          ),
          if (_errorText != null)
            _ErrorTextWidget(errorText: _errorText!)
          else
            _HelperTextWidget(helperText: widget.helperText)
        ],
      ),
    );
  }
}

class CustomFormTextFieldStyle {
  CustomFormTextFieldStyle._();

  static const defaultBorderColor = 0xFFC6C7CD;
  static const focusedColor = 0xFF2047E0;
  static const errorColor = 0xFFEB0433;
  static const labelColor = 0xFF57595F;
  static const helperTextColor = 0xFF1D1E22;
  static const double focusedBorderWidth = 2;
  static const double unfocusedBorderWidth = 1;
  static const double maxBorderInternalSpaceUsed = 2;
}
