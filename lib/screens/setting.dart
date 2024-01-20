import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Cart.dart';
import 'HomePage.dart';

class mySetting extends StatefulWidget {
  const mySetting({super.key});

  @override
  State<mySetting> createState() => _mySettingState();
}

class _mySettingState extends State<mySetting> {

  final User? user=FirebaseAuth.instance.currentUser;
  CollectionReference adresses = FirebaseFirestore.instance.collection('adresses');
  //String data=FirebaseFirestore.instance.collection('users').where('address').get() as String;
  String temp="";
  String adress="";
  Future<void> getUserAdress() async{
    final temp=await adresses.doc("adresses").get();
    adress=temp["address"].toString();
  }
  Future<DocumentSnapshot<Map<String,dynamic>>> getUserDetail() async{
    return await FirebaseFirestore.instance.collection("users").doc(user!.email).get();
  }
 @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile "),
        ),
        backgroundColor: Colors.white54,
      body:
      FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: getUserDetail(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot)
    {
      if (snapshot.connectionState == ConnectionState.waiting) 
      {
        return  Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Loading.."),
              CircularProgressIndicator(
                color: Colors.deepOrangeAccent.shade100,
              ),
            ],
          ),
        );
      }
      else if (snapshot.hasError)
      {
        return Text("Error${snapshot.error}");
      }
      else if (snapshot.hasData)
      {
        Map<String, dynamic>? user = snapshot.data!.data();

        return Column(
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 5,left: 20,right: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                 border: Border.all(
                   width: 2,
                   color: Colors.white70
                 ),
                 image:  const DecorationImage(
                   image: AssetImage("data/products/profile.png"),
                   fit: BoxFit.cover

                 )
                ),
              height: 100,width: 100,
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(bottom: 5,left: 20,right: 30),
              child: Text(user!['name'],style: const TextStyle(
                fontSize: 19,fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,left: 0,bottom: 5),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width/1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 20.0,
                      spreadRadius: -20.0,
                      offset: Offset(0.5,0.5),
                    )
                  ],
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        SizedBox(width: 20,),
                        Icon(Icons.notifications_none_rounded,),
                        SizedBox(width: 15,),
                        Text("Notification")
                      ],
                    ),
                    Container(
                      child: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,left: 0,bottom: 5),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width/1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 20.0,
                      spreadRadius: -20.0,
                      offset: Offset(0.5,0.5),
                    )
                  ],
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20,),
                        const Icon(Icons.email,),
                        const SizedBox(width: 15,),
                        Text(user['userEmail']),
                      ],
                    ),
                    Container(
                      child: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,left: 0,bottom: 5),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width/1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 20.0,
                      spreadRadius: -20.0,
                      offset: Offset(0.5,0.5),
                    )
                  ],
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20,),
                        const Icon(Icons.remove_red_eye,),
                        const SizedBox(width: 15,),
                        Text(user['password'])
                      ],
                    ),
                    Container(
                      child: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyCart())),
              child: Padding(
                padding: const EdgeInsets.only(top: 5,left: 0,bottom: 5),
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width/1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 20.0,
                        spreadRadius: -20.0,
                        offset: Offset(0.5,0.5),
                      )
                    ],
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.card_travel,),
                          SizedBox(width: 15,),
                          Text("Cart")
                        ],
                      ),
                      Container(
                        child: const Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage())),
              child: Padding(
                padding: const EdgeInsets.only(top: 20,left: 20,bottom: 10),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orangeAccent,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 20.0,
                        spreadRadius: -20.0,
                        offset: Offset(0.5,0.5),
                      )
                    ],
                  ),
                  child:  const Row(
                    children: [
                      SizedBox(width: 20,),
                      Icon(Icons.logout_sharp,color: Colors.black),
                      SizedBox(width: 10,),
                      Text(" Sign Out",style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
      return const CircularProgressIndicator();
    }
    )
    );
  }
}
