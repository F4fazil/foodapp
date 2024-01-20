import 'dart:convert';
import 'package:bhook/models/Biscuits/BiscuitHome.dart';
import 'package:bhook/models/IceCreams/iceHome.dart';
import 'package:bhook/models/Pizzas/pizzaHome.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../detailDescription/detailItem.dart';
import '../detailDescription/detailItem2.dart';
import '../json models/classModel.dart';
import '../models/Desserts/DessertHome.dart';
import '../models/ItemShop.dart';
import '../models/item.dart';
import '../shopTile.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  bool isLiked = false;

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

  void addToCart(Item coffee) {
    Provider.of<itemShop>(context, listen: false).addItem(coffee);
    displaymessage("Add to Cart");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<itemShop>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white.withOpacity(0.9),
                centerTitle: true,
                title: const Text(
                  "Food Ka Hai Mood?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body:
              Column(children: [
                SizedBox(
                  height: 300,
                  child: FutureBuilder(
                      future: readData(),
                      builder: (BuildContext context, data) {
                        if (data.hasData) {
                          List<DataProductModel> item = data.data!;
                          return PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:4,
                            itemBuilder: (BuildContext context, int index) =>
                                Stack(children: [
                              GestureDetector(
                                child: Container(
                                  height: 200,
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 30, bottom: 20, top: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(item[index].path!),
                                          fit: BoxFit.cover),
                                      color: Colors.brown,
                                      borderRadius: BorderRadius.circular(45)),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail(
                                              path: item[index].path!,
                                              name: item[index].name!,
                                              price: 5)));
                                },
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 50, right: 50, top: 150, bottom: 10),
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow:  const <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 20.0,
                                      spreadRadius: -10.0,
                                      offset: Offset(0.0, 25.0),
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            item[index].name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                        for (int i = 0; i < 5; i++)
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 22,
                                          ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Icon(
                                            Icons.gpp_good,
                                            color: Colors.yellow,
                                            size: 22,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "Excellent",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Icon(
                                            Icons.location_on_rounded,
                                            color: Colors.redAccent,
                                            size: 22,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "3.5km",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Icon(
                                            Icons.access_time,
                                            color: Colors.redAccent,
                                            size: 22,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 1),
                                          child: Text(
                                            "25 min",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 125, right: 125, top: 270),
                                child: DotsIndicator(
                                  dotsCount: item.length,
                                  position: index,
                                  decorator: DotsDecorator(
                                    activeColor:
                                        Colors.black,
                                    size: const Size.square(5),
                                    activeSize: const Size(6, 5),
                                    activeShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        } else if (data.hasError) {
                          return Text("${data.error}");
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Categories',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
                 // Divider(),
                 Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const DessertHome())),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage("data/dessert/d1.jpg"),
                                    fit: BoxFit.cover),
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(45)),
                          ),
                        ),
                        Text("Desserts",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(width: 25,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const BiscuitHome())),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage("data/Biscuits/b1.jpg"),
                                    fit: BoxFit.cover),
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(45)),
                          ),
                        ),
                        const Text("Biscuits",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(width: 25,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const IceHome())),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage("data/IceCreams/i1 (2).jpg"),
                                    fit: BoxFit.cover),
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(45)),
                          ),
                        ),
                        const Text("IceCreams",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(width: 25,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const PizzaHome())),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage("data/pizzas/p1 (2).jpg"),
                                    fit: BoxFit.cover),
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(45)),
                          ),
                        ),
                        const Text("Pizzas",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
               SizedBox(height: 10,),
                const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Popular Meals',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
               // const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.itemshop.length,
                    itemBuilder: (BuildContext context, int index) {
                      final eachItem = value.itemshop[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyDetail(
                                      obj: eachItem,
                                    ))),
                        child: coffeTile(
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
                ),
              ]),
            ));
  }

  //categories data fetching
  Future<List<DataProductModel>> readData() async {
    String jsonData =
        await DefaultAssetBundle.of(context).loadString('data/data.json');
    List temp = json.decode(jsonData);
    List<DataProductModel> dataproducmodel = temp
        .map((dataproducmodel) => DataProductModel.fromJson(dataproducmodel))
        .toList();
    return dataproducmodel;
  }

  //products data fetching fom json
  Future<List<product>> readProduct() async {
    String jsonData =
        await DefaultAssetBundle.of(context).loadString("data/product.json");
    List temp = json.decode(jsonData);
    List<product> prd = temp.map((prd) => product.fromJson(prd)).toList();
    return prd;
  }

  //recommeneded
  Future<List<recommended>> readReco() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("data/recommended.json");
    List temp = json.decode(jsonData);
    List<recommended> product =
        temp.map((product) => recommended.fromJson(product)).toList();
    return product;
  }
}
