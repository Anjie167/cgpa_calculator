import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField(
      {Key? key,
        this.controller,
        this.icon,
        required this.hintText,
        required this.inputType,
        this.showText = true,
        required this.topPadding,
        required this.bottomPadding,
        this.suffixIcon,
        this.label,
        this.enabled = true, this.onTap, this.inputFormatters})
      : super(key: key);

  final TextEditingController? controller;
  final IconData? icon;
  final String hintText;
  final TextInputType inputType;
  final bool showText;
  final String? label;
  final bool enabled;
  final double topPadding;
  final double bottomPadding;
  final IconData? suffixIcon;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if(widget.label != null)Row(
          children: [
            SizedBox(width: w*0.01,),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: Text(widget.label!, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w300),),
            ),
          ],
        ),
        Container(
          height: h * 0.065,
          margin:
          EdgeInsets.only(bottom: widget.bottomPadding, top: widget.topPadding),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.grey)),
          child: Center(
            child: TextField(
              showCursor: true,
              enabled: widget.enabled,
              obscureText: !widget.showText,
              keyboardType: widget.inputType,
              controller: widget.controller,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: (widget.icon != null)
                      ? Icon(
                    widget.icon,
                    color: Colors.grey.withOpacity(0.8),
                    size: 30,
                  )
                      : const SizedBox.shrink(),
                  suffixIcon: (widget.suffixIcon != null)
                      ? IconButton(icon: Icon(widget.suffixIcon), onPressed: widget.onTap,)
                      : const SizedBox.shrink(),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6,), fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }
}
