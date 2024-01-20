import 'package:flutter/material.dart';
ThemeData darkTheme=ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  colorScheme:  ColorScheme.dark(
    secondary: Colors.grey.shade700,
    primary:Colors.grey.shade700,
    inversePrimary: Colors.grey.shade700

  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),


);