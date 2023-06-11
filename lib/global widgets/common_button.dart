import 'package:cgpa_calcultor/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  const CommonButton(
      {Key? key,
        this.fillColor,
        this.borderColor,
      required this.text,
      this.alignment,
      required this.textColor,
      required this.onPress,
       this.topPadding,
        this.borderRadius,
        this.bottomPadding})
      : super(key: key);

  final Color? fillColor;
  final Color? borderColor;
  final String text;
  final TextAlign? alignment;
  final Color textColor;
  final Function()? onPress;
  final double? topPadding;
  final double? bottomPadding;
  final double? borderRadius;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        margin: EdgeInsets.only(
            bottom: widget.bottomPadding ?? 0, top: widget.topPadding ?? 0),
        width: width,
        height: height * 0.065,
        decoration: BoxDecoration(
            color: widget.fillColor ?? kPrimaryBase,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 15),
            border: Border.all(color: widget.borderColor ?? kPrimaryBase)),
        child: Center(
            child: Text(
          widget.text,
          textAlign: widget.alignment ?? TextAlign.center,
          style: TextStyle(color: widget.textColor, fontSize: 18, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
