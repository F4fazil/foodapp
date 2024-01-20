import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final String hinttext;
  final bool Obsecuretext;
  const Mytextfield(
      {Key? key,
      required this.controller,
      required this.hinttext,
      required this.Obsecuretext, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: Obsecuretext,
      style:  const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          prefixIcon:icon,
          enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: Colors.deepOrange.shade100, width: 2),

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color:  Colors.deepOrange.shade200,width: 3.2),
          ),
          fillColor: Colors.white.withOpacity(0.7),

          filled: true,
          hintText:hinttext),
    );
  }
}
