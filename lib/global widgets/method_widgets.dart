import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/global.dart';
import 'editable_icon.dart';

AppBar customAppBar(context,
    {required String title, Widget? trailIcon, Widget? leadIcon, Function()? onTap, Color? color}) {
  return AppBar(
    backgroundColor: color ?? Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: leadIcon ?? GestureDetector(
      onTap: onTap ?? (){
        Navigator.pop(context);
      },
        child: const Icon(Icons.arrow_back, color: Colors.black,)),
    title: Text(
      title,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
    ),
    actions: [
      trailIcon ?? const SizedBox.shrink()
    ],
  );
}

Center customLoader(context) {
  var w = Global.getWidth(context);
  return Center(
    child: Container(
      height: w*0.1,
      width: w*0.1,
      padding: EdgeInsets.all(Dimensions.paddingSmall),
      margin: EdgeInsets.all(Dimensions.paddingMedium),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(offset: const Offset(-2, -2), color: Colors.grey.withOpacity(0.2), blurRadius: 5),
            BoxShadow(offset: const Offset(2, 2), color: Colors.grey.withOpacity(0.2), blurRadius: 5)
          ]
      ),
      child: const Center(child: CircularProgressIndicator(color: kPrimaryRed,)),),
  );
}

searchBar(context, {required TextEditingController controller}) {
  var w = Global.getWidth(context);
  var h = Global.getHeight(context);
  return Container(
    height: h * 0.06,
    margin: const EdgeInsets.only(bottom: 30),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * 0.1),
        color: Colors.grey.withOpacity(0.1),
        border: Border.all(color: Colors.grey.withOpacity(0.7))),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: w * 0.04,
        ),
        EditableIcon(
          CupertinoIcons.search,
          size: 30,
          fontWeight: FontWeight.w100,
          color: Colors.grey.withOpacity(0.7),
        ),
        SizedBox(
          width: w * 0.05,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7), fontSize: 17),
            hintText: "Search crypto and Forex Pairs",
            border: InputBorder.none
          ),
        ),
      ],
    ),
  );
}

Padding titleBar(name, {double? fontSize, Color? color}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Text(
      name,
      style: TextStyle(fontSize: fontSize ?? 23, fontWeight: FontWeight.w500, color: color ?? Colors.white),
    ),
  );
}

