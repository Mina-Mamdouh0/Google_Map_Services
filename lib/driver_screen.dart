
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/login_screen.dart';
import 'package:map/main.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({Key? key}) : super(key: key);

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {

  List<dateModel> data=[];

  void getData(){
    //data.clear();
    FirebaseFirestore.instance.collection('Other').get()
        .then((value){
          for (var element in value.docs) {
            data.add(dateModel.formJson(element.data()));
          }
    });
    setState(() {

    });

  }

  @override
  void initState() {
   getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text('Orders'),
          actions: [
            IconButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut().whenComplete((){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  });
                },
                icon: Icon(Icons.login)),
            const SizedBox(width: 5,),
            IconButton(
                onPressed: (){
                  data=[];
                  setState(() {

                  });
                },
                icon: Icon(Icons.update)),
          ],
        ),
      body: RefreshIndicator(
        onRefresh: ()async{
          getData();
        },
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context,index){
              return Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data[index].location),
                    const SizedBox(height: 2,),
                    data[index].state=='Finish'?
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 12.0),
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                        ),
                        onPressed: (){
                          DataDiv.lngOther=data[index].lngOther;
                          DataDiv.latOther=data[index].latOther;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderTrackingPage1()));

                        },
                        child: const Text(
                          'show Location',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ):
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child:ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 12.0),
                                ),
                                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                              ),
                              onPressed: (){
                                FirebaseFirestore.instance.collection('Other')
                                    .doc(data[index].Uid).update({
                                  'state':'Finish',
                                });
                                data=[];
                                setState(() {});
                              },
                              child: const Text(
                                'Confirm',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ), ),
                        const SizedBox(width: 5,),
                        IconButton(
                            onPressed: (){
                              /*setState(() {

                              });*/
                              DataDiv.lngOther=data[index].lngCurrent;
                              DataDiv.latOther=data[index].latCurrent;
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderTrackingPage1()));

                            },
                            icon: Icon(Icons.location_on_outlined))
                      ],
                    )

                  ],
                ),
              );
            }),
      ),

    );
  }
}

class OrderTrackingPage1 extends StatefulWidget {
  const OrderTrackingPage1({Key? key,}) : super(key: key);

  @override
  State<OrderTrackingPage1> createState() => _OrderTrackingPage1State();
}

class _OrderTrackingPage1State extends State<OrderTrackingPage1> {
  final Completer<GoogleMapController> _controller = Completer();

     LatLng currentLocation = LatLng(DataDiv.latCurrent, DataDiv.lngCurrent);

    LatLng otherLocation = LatLng(DataDiv.latOther,DataDiv.lngOther);

  List<LatLng> polylineCoordinates =[];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        'AIzaSyA4pF0H-TEDvrtlNFBqor6TJ41EwabE0XE',
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(otherLocation.latitude, otherLocation.longitude)
    ) ;
    if (result.points.isNotEmpty){
      for (var point in result.points) {
        polylineCoordinates.add (
            LatLng(point.latitude, point.longitude)
        );
        setState(() {

        });
      }

    }


  }
  @override
  void initState(){
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track order',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body:  GoogleMap(
        initialCameraPosition:
        CameraPosition(
            target: currentLocation, zoom: 13.15),
        polylines: {
          Polyline(polylineId: const PolylineId("route"),
              points: polylineCoordinates,
              color: Colors.red,
              width: 6

          ),

        },
        markers: {
          Marker(
            markerId:const MarkerId('currentLocation'),
            position: currentLocation,
          ),
          Marker(
            markerId: const MarkerId('source'),
            position: otherLocation,
          ),
        },
        onMapCreated: (mapController){
          _controller.complete(mapController);
        },
      ),
    );
  }
}




class dateModel{
  final String idOrder;
  final double latCurrent;
  final double lngCurrent;
  final double latOther;
  final double lngOther;
  final String location;
  final String state;
  final String Uid;

  dateModel({required this.idOrder,
    required this.latCurrent,
    required this.lngCurrent,
    required this.latOther,
    required this.lngOther,
    required this.Uid,
    required this.location,required this.state});
  factory dateModel.formJson(Map<String, dynamic> json,){
    return dateModel(
      idOrder: json['idOrder'],
      latCurrent:json['latCurrent'],
      lngCurrent: json['lngCurrent'],
      latOther: json['latOther'],
      lngOther: json['lngOther'],
      location: json['location'],
      state: json['state'],
      Uid: json['Uid'],
    );
  }
}
