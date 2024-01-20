import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../authentication/SignupPage.dart';
import '../widgets/textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final email = TextEditingController();
  final password = TextEditingController();
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
  //signIN
  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      displaymessage("Signing in");
    } on FirebaseException catch (e) {
     displaymessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width / 2.3,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(120),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("data/logo.jpg"),
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 20.0,
                    spreadRadius: -10.0,
                    offset: Offset(25, 25.0),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Hello",
              style: TextStyle(
                  color: Colors.black, fontSize: 70, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Sign in to you account",
              style: TextStyle(
                  color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Mytextfield(
                  controller: email,
                  hinttext: 'Email',
                  Obsecuretext: false,
                  icon: const Icon(Icons.mail_sharp,color: Colors.deepOrangeAccent,),
                )),
            const SizedBox(
              height: 25,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Mytextfield(
                  controller: password,
                  hinttext: 'Password',
                  Obsecuretext: true,
                  icon: const Icon(Icons.password,color: Colors.deepOrangeAccent,),
                )),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              height: MediaQuery.of(context).size.height*0.06,
              child: ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.deepOrangeAccent.shade100)),
                    backgroundColor: Colors.deepOrangeAccent.shade100,
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Does not have an account?',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
