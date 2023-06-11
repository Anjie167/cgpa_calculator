import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.label,
    required this.onTap,
    required this.icon, this.customColor,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Function() onTap;
  final Color? customColor;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 20, bottom: 25),
        child: Row(
          children: [
            Icon(
              icon,
              color: customColor ?? Colors.black,
            ),
            SizedBox(
              width: width * 0.04,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 17,
                  color: customColor ?? Colors.black87.withOpacity(0.75),
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
