import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'main.dart';


class OtherLocation extends StatefulWidget{
  @override
  _OtherLocationState createState() => _OtherLocationState();
}

class _OtherLocationState extends State<OtherLocation> {
  String googleApikey = "AIzaSyA4pF0H-TEDvrtlNFBqor6TJ41EwabE0XE";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(Data.latCurrent, Data.lngCurrent);
  String location = "Location Name:";
  double? lat;
  double? lng;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Longitude Latitude Picker in Google Map"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(
            children:[

              GoogleMap( //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition( //innital position in map
                  target: startLocation, //initial position
                  zoom: 14.0, //initial zoom level
                ),
                mapType: MapType.normal, //map type
                onMapCreated: (controller) { //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona; //when map is dragging
                },
                onCameraIdle: () async { //when map drag stops
                  List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                  setState(() {
                    lat=cameraPosition!.target.latitude;
                    lng=cameraPosition!.target.longitude;
                    location = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
                    print('$lng & $lat');
                    if(lat!=null && lng!=null){
                      Data.latOther=lat!;
                      Data.lngOther=lng!;
                      Data.location=location;
                    }
                  });
                },
              ),

              Center( //picker image on google map
                child: Icon(Icons.place),
              ),
              Positioned(  //widget to display location name
                  bottom:100,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            leading: Icon(Icons.place),
                            title:Text(location, style: TextStyle(fontSize: 18),),
                            dense: true,
                          )
                      ),
                    ),
                  )
              )
            ]
        )
    );
  }
}