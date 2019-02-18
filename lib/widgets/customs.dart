import 'package:flutter/material.dart';

Text texteStyle(String data,
    {color: Colors.white,
    fontSize: 18.0,
    fontStyle: FontStyle.italic,
    textAlign: TextAlign.center}) {
  return new Text(
    data,
    textAlign: textAlign,
    style: TextStyle(color: color, fontStyle: fontStyle, fontSize: fontSize),
  );
}


