
import 'package:bhook/authentication/auth.dart';
import 'package:bhook/models/Biscuits/BiscuitShop.dart';
import 'package:bhook/models/Desserts/DessertItem.dart';
import 'package:bhook/models/IceCreams/iceShop.dart';
import 'package:bhook/models/ItemShop.dart';
import 'package:bhook/models/Pizzas/pizzaShop.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'map_Integration/adresses.dart';

void main() async {
  Stripe.publishableKey = 'pk_test_51OFewFLG8GWemPagc5fLK4VvJ4e1smN0zMAi2CHkoba7FlxmjddLCcvyMFgxdlPTF2zUPIb5rYPfkDWkSVWT5m5E0046sHPVee';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<itemShop>(
            create: (_) => itemShop(),
          ),
          ChangeNotifierProvider<DessertShop >(
            create: (_) => DessertShop() ,
          ),
          ChangeNotifierProvider<BiscuitShop>(
            create: (_) => BiscuitShop(),
          ),
          ChangeNotifierProvider<IceCream>(
            create: (_) => IceCream(),
          ),
          ChangeNotifierProvider<PizzaShop>(
            create: (_) => PizzaShop(),
          ),
         // Provider<SomethingElse>(create: (_) => SomethingElse()),
          //Provider<AnotherThing>(create: (_) => AnotherThing()),
        ],
        child:   MaterialApp(
          debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.deepOrangeAccent.shade100,
              textTheme: GoogleFonts.poppinsTextTheme(
               ThemeData().textTheme,
              )
            ),
            home:   const AuthPage())),
      );
}