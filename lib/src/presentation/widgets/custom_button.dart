import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Text? text;
  final Text? subtext;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool alignIconEdge;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final int colorCode;
  final double? width;
  final double? height;
  final double? borderRadius;
  final void Function()? onPressed;
  final double? elevation;

  const CustomButton({
    Key? key,
    this.text,
    this.subtext,
    this.leadingIcon,
    this.trailingIcon,
    this.padding,
    this.margin,
    this.colorCode = 0XFF0067FF,
    this.width,
    this.height,
    this.borderRadius,
    this.onPressed,
    this.alignIconEdge = false,
    this.elevation,
  })  : assert(
          text != null || leadingIcon != null,
          'Must have text or leadingIcon',
        ),
        assert(
          text != null || subtext == null,
          'Must have text to have subtext',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconOnly = text == null;

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: Color(colorCode),
          shape: iconOnly
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 16),
                ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(24.0),
          child: _buildButtonContent(),
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    final textContent = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (text != null) text!,
        if (subtext != null) subtext!,
      ],
    );

    return Row(
      mainAxisAlignment: _getIconsAlignment(),
      children: [
        if (leadingIcon != null) leadingIcon!,
        if (leadingIcon != null && text != null) SizedBox(width: alignIconEdge ? 4 : 8),
        if (text != null)
          alignIconEdge
              ? Expanded(
                  child: textContent,
                )
              : textContent,
        if (trailingIcon != null && text != null) SizedBox(width: alignIconEdge ? 4 : 8),
        if (trailingIcon != null) trailingIcon!,
      ],
    );
  }

  MainAxisAlignment _getIconsAlignment() {
    final leadingIconOnly = leadingIcon != null && trailingIcon == null;
    final trailingIconOnly = leadingIcon == null && trailingIcon != null;

    return alignIconEdge && leadingIconOnly
        ? MainAxisAlignment.start
        : alignIconEdge && trailingIconOnly
            ? MainAxisAlignment.end
            : MainAxisAlignment.center;
  }
}
