import 'package:bhook/models/Biscuits/Biscuit.dart';
import 'package:bhook/models/Biscuits/Biscuit.tile.dart';
import 'package:bhook/models/Biscuits/BiscuitShop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../detailDescription/detailItem.dart';
import '../ItemShop.dart';
import '../item.dart';

class BiscuitHome extends StatelessWidget {
  const BiscuitHome({super.key});

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

    CollectionReference _cart = FirebaseFirestore.instance.collection('cart');



    addTwoFunction( String name, String path, String des, double price){
      _cart.doc("items").set({
          "name": name.toString(),
          "path": path.toString(),
          "description": des.toString(),
          "price": price.toDouble(),
        });
      print("added to firebase");
        void addToCart(Item coffee) {
        Provider.of<itemShop>(context, listen: false).addItem(coffee);
        displaymessage("Add to Cart");
       }
      print("added to cart");
    }

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.deepOrangeAccent.shade100,
        centerTitle: true,
        title: Text("Biscuits"),
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
              child: Consumer<BiscuitShop>(
                  builder: (BuildContext context, value, Widget? child) =>
                      Scaffold(
                        body: ListView.builder(
                          itemCount: value.Biscuitshop.length,
                          itemBuilder: (BuildContext context, int index) {
                            final eachItem = value.Biscuitshop[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detail(
                                            path: eachItem.path,
                                            name: eachItem.name,
                                            price: eachItem.price,
                                          ))),
                              child: biscuitTile(
                                obj: eachItem,
                                onPressed: () {
                                  addTwoFunction(eachItem.name, eachItem.path,
                                      eachItem.description, eachItem.price);
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
          SizedBox(
            height: 25,
            child: Container(
              color: Colors.deepOrangeAccent.shade100,
            ),
          ),
        ],
      ),
    );
  }
}
