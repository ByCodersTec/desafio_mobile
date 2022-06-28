part of '../custom_form_text_field.dart';

class _ErrorTextWidget extends StatelessWidget {
  final String errorText;
  const _ErrorTextWidget({
    Key? key,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
      child: Text(
        errorText,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
      ),
    );
  }
}
