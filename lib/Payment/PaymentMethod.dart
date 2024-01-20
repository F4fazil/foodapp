import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
   final void Function() ontap;
  const Payment({super.key, required this.ontap});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? paymentIntent;

  doPayment() async {
    try {
      Map<String, dynamic> _body = {
        "amount": "100",
        "currency": "USD"};
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

  Future<void> MakePayment() async {
    try {
      paymentIntent = await doPayment();
      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "US",
        testEnv: true,
      );
       await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent![
                "client_secret"],
            style: ThemeMode.dark,
            googlePay: gpay,
            merchantDisplayName: "fazil"),
      );
      displayPayment();
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment successfull")));
      print("done");
    } on StripeException catch (e) {
      print("exception" + e.toString());
      showDialog(
          context: context,
          builder: (_) => AlertDialog(content: Text("Payment Field",style: TextStyle(fontSize: 15),)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            MakePayment();
          },
          child: const Text(
            "Start",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
