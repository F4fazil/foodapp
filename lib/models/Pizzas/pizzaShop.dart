import 'package:bhook/models/Pizzas/pizza.dart';
import 'package:flutter/material.dart';
class PizzaShop extends ChangeNotifier {
  final List<Pizza> _shop = [
    Pizza(
        name: "Tikka Pizza",
        path: "data/pizzas/p1 (2).jpg",
        description:
        "The Pizza is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Pizza. It is cheap, nutritious and satisfying ",
        price: 2),
    Pizza( name: "Italian Pizza",
        path: "data/pizzas/p1 (3).jpg",
        description:"The Pizza is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Pizza. It is cheap, nutritious and satisfying",
        price: 1),
    Pizza( name: "BBQ pizza",
        path: "data/pizzas/p1 (4).jpg",
        description:"The Pizza is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Pizza. It is cheap, nutritious and satisfying.",
        price: 3),
    Pizza(
        name: "cheese Pizza",
        path: "data/pizzas/p1 (1).jpg",
        description: "The Pizza is a short, sweet rotary moulded product, developed from the English 'Malted Milk' Pizza. It is cheap, nutritious and satisfying!!",
        price: 1),
  ];
  //ceate user cart
  List<Pizza> _usercart = [];
  //get usercart

  List<Pizza> get PizzaCreamshop => _shop;

  //get cart

  List<Pizza> get userCart {
    return _usercart;
  }
  //add Pizza
  void addPizza(Pizza Pizza) {
    userCart.add(Pizza);
    notifyListeners();
  }

  //emove Pizza
  void removePizza(Pizza Pizza) {
    userCart.remove(Pizza);
    notifyListeners();
  }
  void removeAllPizzaCreams() {
    userCart.clear();
    notifyListeners();
  }
  double getTotalprice(){
    return userCart.fold(0, (previousValue, Pizza) => previousValue+Pizza.price);
  }

}
