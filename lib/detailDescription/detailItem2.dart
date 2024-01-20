import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/ItemShop.dart';
import '../models/item.dart';

class MyDetail extends StatefulWidget {
  final Item obj;
   MyDetail({super.key, required this.obj});

  @override
  State<MyDetail> createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  @override
  Widget build(BuildContext context) {



    Map<String, dynamic>? paymentIntent;
    void displaymessage(String message){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.deepOrange.shade100,
              behavior: SnackBarBehavior.floating,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: EdgeInsets.only(bottom: 40.0),
              elevation: 0,
              duration: Duration(seconds: 1), content: Text(message)));
    }

    //amount calculation
    calculateAmount() {
      String amount=widget.obj.price.toInt().toString();
      print(amount);
      final a = (int.parse(amount)) * 100;
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
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent.shade100,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
            widget.obj.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.obj.path), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.elliptical(4, 5),
                      bottomLeft: Radius.elliptical(4, 5)),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.obj.name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  for (int i = 0; i < 5; i++)
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 22,
                    ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text("(45)"),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Price \$${widget.obj.price}",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontSize: 20,

                        color: Colors.black),
                  ),
                  // add or minus for item
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        "Food is one of the basic necessities of life. Food contains nutrients—substances essential for the growth, repair, and maintenance of body tissues and for the regulation of vital processes. Nutrients provide the energy our bodies need to function. The energy in food is measured in units called calories.",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  // add or minus for item
                ],
              ),
              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total", style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),),
                  const SizedBox(width: 15,),
                  Text("\$${widget.obj.price}", style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child:
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        MakePayment();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent.shade100,
                        shadowColor: Colors.deepOrangeAccent.shade100,
                      ),
                      child: const Text(
                        'Buy',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent.shade100,
                      shadowColor: Colors.deepOrangeAccent.shade100,
                    ),
                    child: const Text(
                      'Back To Home',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
              ),



            ],
          ),
        ));
  }
}
