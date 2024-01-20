import 'Biscuit.dart';
import 'package:flutter/material.dart';

class BiscuitShop extends ChangeNotifier {
  final List<Biscuit> _shop = [
    Biscuit(
        name: "Black Biscuit",
        path: "data/Biscuits/b1.jpg",
        description: "The biscuit is a short, sweet rotary moulded product, developed from the English 'Malted Milk' biscuit. It is cheap, nutritious and satisfying!!",
        price: 1),
    Biscuit(
        name: "Choco Biscuit",
        path: "data/Biscuits/b2.jpg",
        description:
        "The biscuit is a short, sweet rotary moulded product, developed from the English 'Malted Milk' biscuit. It is cheap, nutritious and satisfying ",
        price: 2),
    Biscuit( name: "Brwonie Biscuit",
        path: "data/Biscuits/b3.jpg",
        description:"The biscuit is a short, sweet rotary moulded product, developed from the English 'Malted Milk' biscuit. It is cheap, nutritious and satisfying",
        price: 1),
    Biscuit( name: "Italian Biscuits",
        path: "data/Biscuits/b4.jpg",
        description:"The biscuit is a short, sweet rotary moulded product, developed from the English 'Malted Milk' biscuit. It is cheap, nutritious and satisfying.",
        price: 3),
    Biscuit( name: " Black Biscuits",
        path: "data/Biscuits/b5.jpg",
        description:"The biscuit is a short, sweet rotary moulded product, developed from the English 'Malted Milk' biscuit. It is cheap, nutritious and satisfying ",
        price: 2 )
  ];
  //ceate user cart
  List<Biscuit> _usercart = [];
  //get usercart

  List<Biscuit> get Biscuitshop => _shop;

  //get cart

  List<Biscuit> get userCart {
    return _usercart;
  }
  //add Biscuit
  void addBiscuit(Biscuit Biscuit) {
    userCart.add(Biscuit);
    notifyListeners();
  }

  //emove Biscuit
  void removeBiscuit(Biscuit Biscuit) {
    userCart.remove(Biscuit);
    notifyListeners();
  }
  void removeAllBiscuits() {
    userCart.clear();
    notifyListeners();
  }
  double getTotalPrice(){
    return userCart.fold(0, (previousValue, Biscuit) => previousValue+Biscuit.price);
  }

}
