
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/driver_screen.dart';
import 'package:map/main.dart';
import 'package:permission_handler/permission_handler.dart';

class CurrentDivLocation extends StatefulWidget {
  const CurrentDivLocation({super.key});

  @override
  State<CurrentDivLocation> createState() => _CurrentDivLocationState();
}

class _CurrentDivLocationState extends State<CurrentDivLocation> {

  final TextEditingController addressController = TextEditingController();
  late double lat;
  late double lng;
  bool isLoading = false;
  final Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    map();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {});
    });

    super.initState();
  }
  static CameraPosition? _kGoogle;
  final List<Marker> _markers = <Marker>[];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: size.width,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        SizedBox(
                          height: 300,
                          width:size.width,
                          child: _kGoogle == null
                              ? Container()
                              : GoogleMap(
                            initialCameraPosition: _kGoogle!,
                            markers: Set<Marker>.of(_markers),
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            compassEnabled: true,
                            onMapCreated: (GoogleMapController controller) {
                              setState(() {
                                DataDiv.lngCurrent=_kGoogle!.target.longitude;
                                DataDiv.latCurrent=_kGoogle!.target.latitude;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 200),
                            child: Text("الموقع الحالي ",
                                style: TextStyle(
                                    color: Colors.green.shade900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Text("*",
                              style: TextStyle(
                                  color: Colors.red.shade900,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Text(addressController.text),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        if(addressController.text.isNotEmpty ){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DriverScreen()));
                        }
                      },
                      child: const Text('Back',)),
                ]),
          )),
    );
  }



  map() async {
    try {
      if ((await Permission.location.request()).isGranted) {
        await getUserCurrentLocation().then((value) async {
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {});
          });
          List<Placemark> placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
          Placemark first = placemarks.first;
          String palcename =
              " ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea}, ${first.street}, ${first.name}, ${first.thoroughfare}, ${first.subThoroughfare}'";
          addressController.text = palcename;
          lat = value.latitude;
          lng = value.longitude;
          setState(() {
            DataDiv.latCurrent=lat;
            DataDiv.lngCurrent=lng;
          });
          _markers.add(Marker(
            markerId: const MarkerId("2"),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(
              title: 'My Current Location',
            ),
          ));
          _kGoogle = CameraPosition(
              target: LatLng(value.latitude, value.longitude), zoom: 11);

          final GoogleMapController controller = await _controller.future;
          await controller
              .animateCamera(CameraUpdate.newCameraPosition(_kGoogle!));


          setState(() {

          });
        });
      }
    } catch (e) {
      await getUserCurrentLocation().then((value) async {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {});
        });
        List<Placemark> placemarks =
        await placemarkFromCoordinates(value.latitude, value.longitude);
        Placemark first = placemarks.first;
        String palcename =
            " ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea}, ${first.street}, ${first.name}, ${first.thoroughfare}, ${first.subThoroughfare}'";
        addressController.text = palcename;
        lat = value.latitude;
        lng = value.longitude;
        setState(() {
          DataDiv.latCurrent=lat;
          DataDiv.lngCurrent=lng;
        });
      });
    }
  }
}