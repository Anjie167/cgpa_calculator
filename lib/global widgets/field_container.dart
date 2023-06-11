import 'package:flutter/material.dart';


class FieldContainer extends StatelessWidget {
  const FieldContainer(
      {Key? key,
      this.onSaved,
      this.onTap,
      this.validator,
      this.keyboardType,
      this.initialValue,
      this.hintText,
      this.errorText,
      this.iconData,
      this.labelText,
      this.obscureText,
      this.suffixIcon,
      required this.isFirst,
      required this.isLast,
      this.style,
      this.textAlign,
      this.suffix,
      required this.child})
      : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final Function? onTap;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final IconData? iconData;
  final bool? obscureText;
  final bool isFirst;
  final bool isLast;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
      margin: EdgeInsets.only(
          left: 20, right: 20, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: buildBorderRadius,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
          border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelText ?? "",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: textAlign ?? TextAlign.start,
          ),
          child
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst) {
      return const BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast) {
      return const BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (!isFirst && !isLast) {
      return const BorderRadius.all(Radius.circular(0));
    }
    return const BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst)) {
      return 20;
    } else if (!isFirst) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast)) {
      return 10;
    } else if (!isLast) {
      return 10;
    } else {
      return 0;
    }
  }
}
