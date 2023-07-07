
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map/current_location.dart';
import 'package:map/login_screen.dart';
import 'package:map/main.dart';
import 'package:uuid/uuid.dart';
import 'package:map/order_tracking_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/place_picker.dart';

import 'ather_location.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({Key? key}) : super(key: key);

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Create Order'),
        actions: [
          IconButton(
              onPressed: (){
                FirebaseAuth.instance.signOut().whenComplete((){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                });
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60,),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrentLocation()));
                },
                child: const Text('Current Location',)),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherLocation()));
                },
                child: const Text('Other Location',)),
            const SizedBox(height: 20,),
            /*(Data.lngOther==0&&Data.latOther==0&&Data.lngCurrent==0&&Data.latCurrent==0)?
               Container():*/
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderTrackingPage()));

                },
                child: const Text('Show Map',)),
            const SizedBox(height: 20,),
            isLoading?Center(child: CircularProgressIndicator(),):ElevatedButton(
                onPressed: (){
                  setState(() {
                    isLoading=true;
                  });
                  String uid=const Uuid().v4();
                  FirebaseFirestore.instance.collection('Other')
                      .doc(uid).set({
                    'Uid':uid,
                    'idOrder':FirebaseAuth.instance.currentUser!.uid,
                    'latCurrent':Data.latCurrent,
                    'lngCurrent':Data.lngCurrent,
                    'latOther':Data.latOther,
                    'lngOther':Data.lngOther,
                    'location':Data.location.toString(),
                    'state':'Padding',
                  });
                  setState(() {
                    isLoading=false;
                  });
                },
                child: const Text('Order',)),

          ],
        ),
      ),
    );
  }
}

class MapServices {
  static Future<LocationResult?> pickLocation(
      BuildContext context,
      LatLng initLocation,
      ) async {
    if ((await Permission.location.request()).isGranted) {
      Position pos = await Geolocator.getCurrentPosition();
      initLocation = LatLng(pos.latitude, pos.longitude);
      if (await Permission.location.request().isGranted) {
        LocationResult result =
        await  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlacePicker(
          'AIzaSyA4pF0H-TEDvrtlNFBqor6TJ41EwabE0XE',
          displayLocation: initLocation,
        )));
        return result;
      }
      return LocationResult();
    } else {
      return null;
    }
  }
}
