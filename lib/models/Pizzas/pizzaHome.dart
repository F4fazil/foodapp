
import 'package:bhook/models/Pizzas/pizza.dart';
import 'package:bhook/models/Pizzas/pizzaShop.dart';
import 'package:bhook/models/Pizzas/pizzaTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../detailDescription/detailItem.dart';
class PizzaHome extends StatelessWidget {
  const PizzaHome({super.key});

  @override
  Widget build(BuildContext context) {
    void displaymessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.deepOrange.shade100,
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: EdgeInsets.only(bottom: 40.0),
          elevation: 0,
          duration: Duration(seconds: 1),
          content: Text(message)));
    }

    void addToCart(Pizza coffee) {
      Provider.of<PizzaShop>(context, listen: false).addPizza(coffee);
      displaymessage("Add to Cart");
    }
    return
      Scaffold(
        appBar: AppBar(
        //  backgroundColor: Colors.deepOrangeAccent.shade100,
          centerTitle: true,
          title: Text("Ices"),
          actions: [
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Consumer<PizzaShop>(
                    builder: (BuildContext context, value, Widget? child) =>
                        Scaffold( body: ListView.builder(
                          itemCount: value.PizzaCreamshop.length,
                          itemBuilder: (BuildContext context, int index) {
                            final eachItem = value.PizzaCreamshop[index];
                            return GestureDetector(
                              onTap: () =>
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail(
                                            path: eachItem.path, name: eachItem.name, price: eachItem.price,
                                          ))),
                              child: PizzaTile(
                                obj: eachItem,
                                onPressed: () {
                                  addToCart(eachItem);
                                },
                                icon: const Icon(
                                  Icons.add_shopping_cart_rounded,
                                  color: Colors.red,
                                  size: 17,
                                ),
                              ),
                            );
                          },
                        ),
                        ))),
            SizedBox(height: 25,
              child: Container(
                color: Colors.white54,
              ),),
          ],
        ),
      );
  }
}
