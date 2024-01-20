import 'item.dart';
import 'package:flutter/material.dart';

class itemShop extends ChangeNotifier {
  final List<Item> _shop = [
    Item(
        name: "Cheese Burger",
        path: "data/products/beef.jpg",
        description: "Mighty Cheese burger with mayo and garlic sauce!!",
        price: 6),
    Item(
        name: "Donut",
        path: "data/header/donut.jpg",
        description:
            "Empower your team to engage in more strategic conversations ",
        price: 4),
    Item( name: "Chinese",
          path: "data/products/chinese.jpg",
          description:"Chinese food staples such as rice, \nsoy sauce, noodles, tea, chili oil, and tofu,",
          price: 8),
    Item( name: "Italian foodie",
        path: "data/products/italian.jpg",
        description:"A comprehensive site for those who love Italian cuisine. IFF contains hundreds of recipes, cooking tips, and stories about life in Umbria.",
        price: 5),
    Item( name: " cheese pizza",
        path: "data/products/pizza.jpg",
        description:"Malai Boti Pizza,Kabab Stuffer Pizza,Pizza Sandwich · Flaming Pasta. ",
        price: 2 )
  ];
  //ceate user cart
  List<Item> _usercart = [];
  //get usercart

  List<Item> get itemshop => _shop;

  //get cart

  List<Item> get userCart {
    return _usercart;
  }
  //add item
  void addItem(Item item) {
    userCart.add(item);
    notifyListeners();
  }

  //emove item
  void removeItem(Item item) {
    userCart.remove(item);
    notifyListeners();
  }
  void removeAllItems() {
    userCart.clear();
    notifyListeners();
  }
  double getTotalPrice(){
    return userCart.fold(0, (previousValue, item) => previousValue+item.price);
  }

}
