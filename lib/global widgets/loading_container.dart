import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    Key? key,
     this.bottom = 0,
    this.top = 0, this.borderRadius, required this.color,
  }) : super(key: key);

  final Color color;
  final double bottom, top;
  final double? borderRadius;


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: bottom, top: top),
      width: width,
      height: height * 0.072,
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          border: Border.all(color: color)),
      child: Center(
          child: CircularProgressIndicator(
        color: color,
      )),
    );
  }
}
