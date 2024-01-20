import 'dart:async';
import 'package:bhook/screens/WelcomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/textfield.dart';

class googleMap extends StatefulWidget {
  const googleMap({super.key});

  @override
  State<googleMap> createState() => _googleMapState();
}

class _googleMapState extends State<googleMap> {
  TextEditingController controller = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  CollectionReference adresses =
      FirebaseFirestore.instance.collection('adresses');
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserAdress() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc("adresses")
        .get();
  }

  // var uid = const Uuid();
  String stAdress = "";
  bool bToggle = true;
  String sessiontoken = "1234";
  List<dynamic> _position = [];
  static const String Google_Map_Api_key =
      "AIzaSyAZxGaoI-J0DeAx8mywlYMnPre_utQkTdE";
  // Location _location = Location();
  final Completer<GoogleMapController> _mapController = Completer();
  static const LatLng _googlePlex = LatLng(31.446, 74.2682);
  //static const LatLng _applePlex = LatLng(31.4843, 74.2969);
  LatLng? _currentP = null;
  // Map <PolylineId,Polyline> polylines={};
  final List<Marker> _markers = <Marker>[];
  loadData() {
    _determinePosition().then((value) async {
      print("My curent location");
      print(value.latitude.toString() + "  " + value.longitude.toString());
      _markers.add(
        Marker(
          markerId: const MarkerId("MY_Current_Location"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: stAdress),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              (bToggle) ? BitmapDescriptor.hueYellow : BitmapDescriptor.hueOrange),
        ),
      );
      CameraPosition position = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude),
      );
      GoogleMapController controller = await _mapController.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        position,
      ));
      List<Placemark> placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      print("placeMarks");
      print(placemarks);
      setState(() {
        stAdress = "${placemarks.reversed.last.subThoroughfare!},${placemarks.reversed.last.subLocality!},${placemarks.reversed.last.locality!}";
      });
      makeUserDocument(stAdress.toString());
    });
  }

  Future<void> makeUserDocument(String userCredential) {
    return adresses.add({
      "address": stAdress.toString(),
    });
  }

  //getting user current position
  Future<Position> _determinePosition() async {
    await Geolocator.checkPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // _currentP==null? Center(child: CircularProgressIndicator()) :
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserAdress(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Loading ....."),
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
              return Stack(children: [

                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: MediaQuery.of(context).size.height / 2.4,
                    width: MediaQuery.of(context).size.width/1,
                    child: GoogleMap(
                      onMapCreated: ((GoogleMapController controller) =>
                          _mapController.complete(controller)),
                      mapType: MapType.normal,
                      initialCameraPosition:
                          const CameraPosition(target: _googlePlex, zoom: 14),
                      markers: Set<Marker>.of(_markers),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50,left: 60,right: 40),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.location_on,
                          color:Colors.black,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 5,
                        ), Text(
                          user!["adress"],
                          style: GoogleFonts.kanit(
                              fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      top: 500,
                      left: 35,
                      bottom: 10
                    ),
                    child: Column(
                      children: [
                         const Padding(
                          padding:  EdgeInsets.only(right: 60),
                          child: Text("     Where are you now?",style: TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold
                          ),),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Center(
                          child: Text("I need to know you where you are so\n     i can show you what i have\n         reviewed around you.",style: TextStyle(
                            fontSize: 15,color: Colors.grey
                          ),),
                        ),
                        const SizedBox(height: 20,),
                        Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape:  RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(color: Colors.white)),
                                      backgroundColor: Colors.orangeAccent,
                                    ),
                                    onPressed: () {
                                      loadData();
                                    },
                                    child: const Text(
                                      "Get Adress",
                                      // List<Placemark> placemarks = await placemarkFromCoordinates(value.longitude, value.latitude);
                                      style: TextStyle(color: Colors.white,fontSize:21),
                                    )),
                              ),
                            )),
                      ],
                    )),
              ]);
            }
            return Center(
                child: CircularProgressIndicator(
              color: Colors.deepOrangeAccent.shade100,
            ));
          }),
    );
  }

  Future<void> _cameraToPosition(LatLng newLocation) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition cameraPosition =
        CameraPosition(target: newLocation, zoom: 13);

    await controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // Future<void> getLocationUpdates() async {
  //   bool isEnabled;
  //   PermissionStatus permissonGranted;
  //   isEnabled = await _location.serviceEnabled();
  //   if (isEnabled) {
  //     isEnabled = await _location.requestService();
  //   } else {
  //     return;
  //   }
  //   permissonGranted = await _location.hasPermission();
  //   if (permissonGranted == PermissionStatus.denied) {
  //     permissonGranted = await _location.requestPermission();
  //     if (permissonGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   _location.onLocationChanged.listen((LocationData currentlocation) {
  //     if (currentlocation.latitude != null &&
  //         currentlocation.longitude != null) {
  //       setState(()async {
  //         _currentP =LatLng(currentlocation.latitude!, currentlocation.longitude!);
  //           _cameraToPosition(_currentP!);
  //
  //       });
  //     }
  //   });
  // }
  // Future<List<LatLng>> getPolyLinesPoints()async{
  //   List<LatLng> polylineCoordinates=[];
  //   PolylinePoints polylinePoints=PolylinePoints();
  //   PolylineResult result=
  //   await polylinePoints.getRouteBetweenCoordinates(Google_Map_Api_key,
  //       PointLatLng(_googlePlex.latitude, _googlePlex.longitude),
  //       PointLatLng(_applePlex.latitude, _applePlex.longitude),travelMode: TravelMode.driving);
  //    if(result.points.isNotEmpty){
  //      for (var pointLatLng in result.points) {
  //        polylineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
  //      }
  //    }
  //    else
  //      {
  //        print(result.errorMessage);
  //      }
  //    return polylineCoordinates;
  // }
  // void generatePolylines(List<LatLng> polyLineCoordinates){
  //   PolylineId id=const PolylineId("poly");
  //   Polyline polyline=Polyline(polylineId: id,color: Colors.black,width: 8,
  //   points: polyLineCoordinates);
  //   setState(() {
  //     polylines[id]=polyline;
  //   });
  // }
}
