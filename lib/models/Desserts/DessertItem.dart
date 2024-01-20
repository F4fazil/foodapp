import 'Dessert.dart';
import 'package:flutter/material.dart';

class DessertShop extends ChangeNotifier {
  final List<Dessert> _shop = [
    Dessert(
        name: "Cheese durger",
        path: "data/dessert/d1.jpg",
        description: "The Dessert is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Dessert. It is cheap, nutritious and satisfying!!",
        price: 1),
    Dessert(
        name: "Alcavio dessert",
        path: "data/dessert/d2.jpg",
        description:
        "The Dessert is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Dessert. It is cheap, nutritious and satisfying ",
        price: 2),
    Dessert( name: "Brown Dessert",
        path: "data/dessert/d3.jpg",
        description:"The Dessert is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Dessert. It is cheap, nutritious and satisfying",
        price: 1),
    Dessert( name: "Italian Desserts",
        path: "data/dessert/d4.jpg",
        description:"The Dessert is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Dessert. It is cheap, nutritious and satisfying.",
        price: 3),
    Dessert( name: " black Desserts",
        path: "data/dessert/d5.jpg",
        description:"The Dessert is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Dessert. It is cheap, nutritious and satisfying ",
        price: 2 )
  ];
  //ceate user cart
  List<Dessert> _usercart = [];
  //get usercart

  List<Dessert> get Dessertshop => _shop;

  //get cart

  List<Dessert> get userCart {
    return _usercart;
  }
  //add Dessert
  void addDessert(Dessert Dessert) {
    userCart.add(Dessert);
    notifyListeners();
  }

  //emove Dessert
  void removeDessert(Dessert Dessert) {
    userCart.remove(Dessert);
    notifyListeners();
  }
  void removeAllDesserts() {
    userCart.clear();
    notifyListeners();
  }
  double getTotalPrice(){
    return userCart.fold(0, (previousValue, Dessert) => previousValue+Dessert.price);
  }

}
