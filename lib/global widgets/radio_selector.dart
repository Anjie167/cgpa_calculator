import 'package:flutter/material.dart';

import '../utils/global.dart';

class RadioSelector extends StatefulWidget {
  const RadioSelector(
      {Key? key,
        required this.label,
        required this.selected,
        required this.onChanged, required this.width, this.color, this.textColor, this.fontWeight, this.centerText = true, this.activeColor})
      : super(key: key);

  final String label;
  final String selected;
  final Function(String?) onChanged;
  final double width;
  final Color? color;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool? centerText;
  final Color? activeColor;

  @override
  State<RadioSelector> createState() => _RadioSelectorState();
}

class _RadioSelectorState extends State<RadioSelector> {
  @override
  Widget build(BuildContext context) {
    var h = Global.getHeight(context);
    return Row(
      children: [
        Radio(
          activeColor: widget.activeColor,
            value: widget.label,
            groupValue: widget.selected,
            onChanged: widget.onChanged),
        Container(
          height: h * 0.06,
          width: widget.width,
          padding: !widget.centerText! ? const EdgeInsets.symmetric(vertical: 10, horizontal: 10) : null,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border:
              Border.all(color: widget.color != null ? widget.color! : widget.selected == widget.label ? Colors.lightBlueAccent : Colors.lightBlueAccent.withOpacity(0.3))),
          child: (widget.centerText!) ? Center(
              child: Text(
                widget.label,
                style: TextStyle(
                    color: widget.textColor != null ? widget.textColor! : widget.selected == widget.label ? Colors.blueGrey : Colors.blueGrey.withOpacity(0.5),
                    fontWeight: widget.fontWeight ?? FontWeight.w500,
                    fontSize: 16),
              )) :
          Text(
            widget.label,
            style: TextStyle(
                color: widget.textColor != null ? widget.textColor! : widget.selected == widget.label ? Colors.blueGrey : Colors.blueGrey.withOpacity(0.5),
                fontWeight: widget.fontWeight ?? FontWeight.w500,
                fontSize: 16),textAlign: TextAlign.left,
          ),

        )
      ],
    );
  }
}