import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/HomePage.dart';
import '../widgets/textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  void displaymessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.deepOrange.shade100,
            behavior: SnackBarBehavior.floating,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.only(bottom: 30.0),
            elevation: 0,
            duration: const Duration(seconds:5), content: Text(message)));
  }

  void signUp() async{
    if (passwordTextController.text != confirmPasswordTextController.text) {
      displaymessage("Password not match");
      return;
    }
    try {
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      displaymessage("success! Back to login");

         makeUserDocument(userCredential);
    }

    on FirebaseException catch (e)
    {
      AlertDialog(
        title: Text('Error found in:${e.code}',style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),),
      );

    }
  }
  Future<void> makeUserDocument( UserCredential? userCredential)async {
      if(userCredential!=null && userCredential.user!=null){
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.email).set({
          "name":nameTextController.text,
          "userEmail":userCredential.user!.email,
          "password":passwordTextController.text
        });

      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Container(
              height: 150,

              width: MediaQuery.of(context).size.width/2.3,
              decoration:  BoxDecoration(
                color: Colors.blue,
                borderRadius:BorderRadius.circular(120),
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
            const SizedBox(height: 5,),
            const Text(
              "Hello",
              style: TextStyle(
                  color: Colors.black, fontSize: 70, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              " Sign up to your account ",
              style: TextStyle(
                  color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: SingleChildScrollView(
                  child: Mytextfield(
                    controller: nameTextController,
                    hinttext: 'Name',
                    Obsecuretext: false, icon: const Icon(Icons.mail,color: Colors.deepOrangeAccent,),
                  )),
            ),
             const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: SingleChildScrollView(
                  child: Mytextfield(
                    controller: emailTextController,
                    hinttext: 'Email',
                    Obsecuretext: false, icon: const Icon(Icons.mail,color: Colors.deepOrangeAccent,),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: SingleChildScrollView(
                  child: Mytextfield(
                    controller: passwordTextController,
                    hinttext: 'Password',
                    Obsecuretext: true, icon: const Icon(Icons.password,color: Colors.deepOrangeAccent,),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: SingleChildScrollView(
                  child: Mytextfield(
                    controller: confirmPasswordTextController,
                    hinttext: ' Confirm Password',
                    Obsecuretext: true, icon:const Icon( Icons.password,color: Colors.deepOrangeAccent,),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child:    SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.06,
                child: ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    style: ElevatedButton.styleFrom(
                      shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.deepOrangeAccent.shade100)),
                      backgroundColor: Colors.deepOrangeAccent.shade100,
                    ),
                    child: const Text('Sign up',style: TextStyle(
                        fontSize: 20,color: Colors.white
                    ),)),
              ),
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
                  'Already have an account?',
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
                            builder: (context) => const HomePage()));
                  },
                  child: const Text(
                    'Login Now',
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
