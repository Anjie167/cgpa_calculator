import 'package:flutter/material.dart';

class Global {

  static getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static String getApiMessage(Object e, {String message = ""}){
    if(e.toString().contains("Exception: ")){
      return e.toString().split("Exception: ").join();
    }else{
      return message;
    }
  }
}