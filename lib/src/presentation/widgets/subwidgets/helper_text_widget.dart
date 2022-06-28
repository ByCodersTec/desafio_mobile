part of '../custom_form_text_field.dart';

class _HelperTextWidget extends StatelessWidget {
  final String? helperText;
  const _HelperTextWidget({
    Key? key,
    required this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: Text(
        helperText ?? '',
        style: const TextStyle(
          fontSize: 12,
          color: Color(CustomFormTextFieldStyle.helperTextColor),
        ),
      ),
    );
  }
}
