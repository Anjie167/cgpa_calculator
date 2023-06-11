import 'package:flutter/material.dart';

class EditableIcon extends StatelessWidget {
  const EditableIcon(this.icon, {
    super.key,  this.fontWeight, this.color, this.size, this.onTap
  });

  final IconData icon;
  final FontWeight? fontWeight;
  final Color? color;
  final double? size;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        String.fromCharCode(
            icon.codePoint),
        style: TextStyle(
            inherit: false,
            color: color ?? Colors.grey,
            fontSize: size ?? 16.0,
            fontWeight: fontWeight ?? FontWeight.w400,
            package:
            icon.fontPackage,
            fontFamily:
            icon.fontFamily),
      ),
    );
  }
}
