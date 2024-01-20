import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/HomePage.dart';
import '../screens/WelcomePage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return const WelcomePage();
          } else {
            return const HomePage();
          }
        },
      ),
    );
  }
}
