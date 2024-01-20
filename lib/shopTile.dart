import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'models/item.dart';

class coffeTile extends StatefulWidget {
  final Item obj;
  final Widget icon;
  void Function()? onPressed;
  coffeTile(
      {Key? key,
      required this.obj,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  @override
  State<coffeTile> createState() => _coffeTileState();
}

class _coffeTileState extends State<coffeTile> {
  Future<DocumentSnapshot<Map<String, dynamic>>> getCartItem()async {
    return  await FirebaseFirestore.instance.collection("cart").doc("items").get();
  }
  @override
  void initState() {
    super.initState();
    getCartItem();
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getCartItem(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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
          } else if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          } else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data();
            return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10.0,
                      spreadRadius: -10.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: Container(
                  height: 135,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage(user?["path"]),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 20,
                      ),
                      Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user!["name"],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  onPressed: widget.onPressed,
                                  icon: widget.icon,
                                ),
                              ],
                            ),
                            Text(
                              user["description"],
                              maxLines: 3,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                  ),
                                  child: Icon(
                                    Icons.payment,
                                    color: Colors.deepOrangeAccent.shade100,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                   user["price"].toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Icon(
                                    Icons.access_time,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "25 min",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          } else
            return CircularProgressIndicator();
        });
  }
}
