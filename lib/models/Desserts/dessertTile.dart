import 'package:bhook/models/Biscuits/Biscuit.dart';
import 'package:bhook/models/Desserts/Dessert.dart';
import 'package:flutter/material.dart';
class desssertTile extends StatelessWidget {
  final Dessert obj;
  final Widget icon;
  void Function()? onPressed;
  desssertTile({Key? key,  required this.obj,required this.onPressed,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child:Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width/2.2,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage(obj.path),
                        fit: BoxFit.cover
                    )
                ),
              ),
              const SizedBox(width: 10,height: 20,),
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width/2.5,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(obj.name,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        IconButton(onPressed: onPressed,icon: icon,),
                      ],

                    ),
                    Text(obj.description,maxLines: 3,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,),
                          child: Icon(Icons.payment,color: Colors.deepOrangeAccent.shade100,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(obj.price.toString(),style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        const SizedBox(width: 8,),
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
        )
    );
  }
}
