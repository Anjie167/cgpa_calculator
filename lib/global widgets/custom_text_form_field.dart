import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
        this.controller,
        this.icon,
        this.formatters,
        required this.hintText,
        required this.inputType,
        this.showText = true,
        this.topPadding = 0,
        this.bottomPadding = 0,
        this.borderRadius,
        this.suffixIcon,
        this.onTap,
        this.enabled = true, this.label, this.validator, this.suffixWidget, this.prefixWidget})
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
  final double? borderRadius;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final String? label;
  final List<TextInputFormatter>? formatters;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;


    return Padding(
      padding: EdgeInsets.only(top: widget.topPadding!, bottom: widget.bottomPadding!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.label != null)Row(
            children: [
              SizedBox(width: w*0.03,),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text(widget.label!, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
              ),
            ],
          ),
          SizedBox(
            height: h*0.1,
            child: Stack(
              children: [
                Container(
                  height: w*0.14,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(widget.borderRadius ?? 10)
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: (widget.icon == null) ? 20 : 0),
                      child: Stack(
                        children: [
                          TextFormField(
                            showCursor: true,
                            enabled: widget.enabled,
                            obscureText: !widget.showText,
                            keyboardType: widget.inputType,
                            controller: widget.controller,
                            validator: widget.validator,
                            inputFormatters: (widget.formatters == null) ? null : widget.formatters,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                helperText: ' ',
                                border: InputBorder.none,
                                prefixIcon: widget.prefixWidget ?? ((widget.icon != null)
                                    ? Icon(
                                  widget.icon,
                                  color: Colors.grey,
                                )
                                    : null),
                                hintText: widget.hintText,
                                hintStyle: TextStyle(color: kHintText, fontWeight: FontWeight.w400)),
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              widget.suffixWidget ?? ((widget.suffixIcon != null)
                                  ? IconButton(icon: Icon(widget.suffixIcon, color: kHintText,), onPressed: widget.onTap,)
                                  : const SizedBox.shrink()),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
