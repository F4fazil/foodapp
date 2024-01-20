
import 'package:flutter/material.dart';

import 'ice.dart';

class IceCream extends ChangeNotifier {
  final List<Ice> _shop = [
    Ice(
        name: "Choco Ice",
        path: "data/IceCreams/i1 (2).jpg",
        description:
        "The Ice is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Ice. It is cheap, nutritious and satisfying ",
        price: 2),
    Ice( name: "Brwonie Ice",
        path: "data/IceCreams/i1 (3).jpg",
        description:"The Ice is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Ice. It is cheap, nutritious and satisfying",
        price: 1),
    Ice( name: "ChocoBean",
        path: "data/IceCreams/i1 (4).jpg",
        description:"The Ice is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Ice. It is cheap, nutritious and satisfying.",
        price: 3),
    Ice(
        name: "Black Ice",
        path: "data/IceCreams/i1 (1).jpg",
        description: "The Ice is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Ice. It is cheap, nutritious and satisfying!!",
        price: 1),
  ];
  //ceate user cart
  List<Ice> _usercart = [];
  //get usercart

  List<Ice> get IceCreamshop => _shop;

  //get cart

  List<Ice> get userCart {
    return _usercart;
  }
  //add Ice
  void addIce(Ice Ice) {
    userCart.add(Ice);
    notifyListeners();
  }

  //emove Ice
  void removeIce(Ice Ice) {
    userCart.remove(Ice);
    notifyListeners();
  }
  void removeAllIceCreams() {
    userCart.clear();
    notifyListeners();
  }
  double getTotalPrice(){
    return userCart.fold(0, (previousValue, Ice) => previousValue+Ice.price);
  }

}
