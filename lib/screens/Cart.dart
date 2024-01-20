import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/ItemShop.dart';
import '../shopTile.dart';

class MyCart extends StatefulWidget {
  const MyCart(
      {super.key,});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? paymentIntent;
    itemShop item = Provider.of<itemShop>(context);
    void displaymessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.deepOrange.shade100,
              behavior: SnackBarBehavior.floating,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: const EdgeInsets.only(bottom: 40.0),
              elevation: 0,
              duration: const Duration(seconds: 1),
              content: Text(message)));
    }
    void deleteFromCart(eachItem) {
      Provider.of<itemShop>(context, listen: false).removeItem(eachItem);
      displaymessage("Removed From cart");
    }
    calculateAmount() {
      final  String temp=item.getTotalPrice().toInt().toString();
      print(temp);
      final a = (int.parse(temp)) * 100;
      return a.toString();
    }

    //will do payment
    doPayment(String price, String currency) async {
      try {
        Map<String, dynamic> _body = {
          "amount": calculateAmount(),
          "currency": currency
        };
        http.Response response = await http.post(
            Uri.parse("https://api.stripe.com/v1/payment_intents"),
            body: _body,
            headers: {
              "Authorization":
              "Bearer sk_test_51OFewFLG8GWemPagYO4htDImdZoSWM7cxzrHxfdNdiFMY4LCzJjbpBPbveFqSofKivyshM8E8DycDJKWgV8omQNK00lOdjXkSk",
              "Content-Type": "application/x-www-form-urlencoded"
            });
        return json.decode(response.body.toString());
      } catch (e) {
        throw Exception(e.toString());
      }
    }
    void displayPayment() async {
      try {
        await Stripe.instance.presentPaymentSheet();
        setState(() {
          paymentIntent = null;
        });
        displaymessage("Payment success");
        print("Payment done");
      } on StripeException catch (e) {
        print("exception$e");
        displaymessage("Payment Failed");

        print("Payment Failed");
      }
    }
    Future<void> MakePayment() async {
      try {
        paymentIntent = await doPayment("4", "USD");
        var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US",
          currencyCode: "US",
          testEnv: true,
        );
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!["client_secret"],
              style: ThemeMode.light,
              googlePay: gpay,
              merchantDisplayName: "fazil"),
        );
        displayPayment();
      } catch (e) {
        throw Exception(e.toString());
      }
    }
    return Consumer<itemShop>(
      builder: (BuildContext context, value, Widget? child) =>
        Scaffold(
            appBar: AppBar(
              //backgroundColor: Colors.orangeAccent,
              title: const Text("Cart"),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () => item.removeAllItems(),
                    icon: const Icon(Icons.delete_sweep, color: Colors.black,))
              ],
            ),
            body: Column(children: [
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: value.userCart.length,
                    itemBuilder: (context, index) {
                      final eachItem = value.userCart[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.white54,
                              blurRadius: 25.0,
                              spreadRadius: -10.0,
                              offset: Offset(10.0, 10.0),
                            )
                          ],
                        ),
                        height: 180,
                        child: coffeTile(
                          obj: eachItem,
                          onPressed: () {
                            deleteFromCart(eachItem);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    }),
              ),
              const Divider(),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Total", style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),),
                      const SizedBox(width: 15,),
                      Text("\$${value.getTotalPrice()}", style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                ),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        MakePayment();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shadowColor: Colors.orangeAccent,
                      ),
                      child: const Text(
                        'Buy',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ]),
          ),
    );

  }
}
