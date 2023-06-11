import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {Key? key,
      this.controller,
      this.icon,
      this.formatters,
      required this.hintText,
      required this.inputType,
      this.showText = true,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.suffixIcon,
      this.onTap,
      this.suffixIconColor,
      this.enabled = true,
      this.label,
      this.iconColor})
      : super(key: key);

  final TextEditingController? controller;
  final IconData? icon;
  final String hintText;
  final Function()? onTap;
  final TextInputType inputType;
  final bool showText;
  final bool enabled;
  final double? topPadding;
  final double? bottomPadding;
  final IconData? suffixIcon;
  final Color? suffixIconColor, iconColor;
  final String? label;
  final List<TextInputFormatter>? formatters;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          top: widget.topPadding!, bottom: widget.bottomPadding!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Row(
              children: [
                SizedBox(
                  width: w * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    widget.label!,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown.shade300,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: (widget.icon == null) ? 20 : 0),
                child: TextField(
                  showCursor: true,
                  enabled: widget.enabled,
                  obscureText: !widget.showText,
                  keyboardType: widget.inputType,
                  controller: widget.controller,
                  inputFormatters:
                      (widget.formatters == null) ? null : widget.formatters,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: (widget.icon != null)
                          ? Icon(
                              widget.icon,
                              color: widget.iconColor ?? Colors.grey,
                            )
                          : null,
                      suffixIcon: (widget.suffixIcon != null)
                          ? IconButton(
                              icon: Icon(
                                widget.suffixIcon,
                                color: widget.suffixIconColor ?? kHintText,
                              ),
                              onPressed: widget.onTap,
                            )
                          : null,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                          color: kHintText, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
