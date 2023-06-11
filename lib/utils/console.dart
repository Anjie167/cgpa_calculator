import 'package:flutter/foundation.dart';

class Console {
  static log(message) {
    if(kDebugMode){
      print("Log: $message");
    }
  }
}
