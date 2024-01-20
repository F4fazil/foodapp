import 'package:bhook/screens/setting.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'Cart.dart';
import 'Home.dart';
import '../map_Integration/adresses.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  Color? colorBar = Colors.brown.shade700;
  static const iconlist = <IconData>[
    Icons.home,
    Icons.add_location_sharp,
    Icons.zoom_in_outlined,
    Icons.add_location_sharp,
  ];

  final List _pages = [
    const Myhome(), //0
    const googleMap(),
    const MyCart(),
    const mySetting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.orangeAccent,
          //animationCurve: Curves.easeInOutCubic,
          animationDuration: Duration(seconds: 1.toInt()),
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const <Widget>[
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(Icons.location_on_rounded, size: 30),
            Icon(
              Icons.card_travel_sharp,
              size: 30,
            ),
            Icon(
              Icons.person,
              size: 30,
            )
          ]),
      body: _pages[_selectedIndex],
    );
  }
}
