import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map/main.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);


  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static   LatLng currentLocation = LatLng(Data.latCurrent, Data.lngCurrent);
  static  LatLng otherLocation = LatLng(Data.latOther,Data.lngOther);

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
