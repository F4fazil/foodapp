import 'package:flutter/material.dart';
ThemeData lightTheme=ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  colorScheme: const ColorScheme.light(
    secondary: Colors.white,
    primary: Colors.white,
      inversePrimary: Colors.white

  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.blueAccent,
  ),


);