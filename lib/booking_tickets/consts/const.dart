import 'package:flutter/material.dart';

class AppConst {
  static List<BoxShadow> shadow = [
    const BoxShadow(

        color: Color.fromRGBO(17, 20, 23, 1.0),
        offset: Offset(4, 4),
        blurRadius: 7,
        spreadRadius: 1),
    const BoxShadow(

        color: Color.fromRGBO(64, 81, 90, 1.0),
        offset: Offset(-4, -4),
        blurRadius: 7,
        spreadRadius: 1)
  ];
}
