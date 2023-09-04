import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator_android/geolocator_android.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  late GoogleMapController googleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              Position position = await userPosition();

              googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 14)));
            },
            label: Padding(padding: EdgeInsets.all(0)),
            icon: const Icon(Icons.my_location),
          ),
        ),
        // Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Container(
        //       width: MediaQuery.of(context).size.width,
        //       height: MediaQuery.of(context).size.height / 2.5,
        //       decoration: BoxDecoration(color: Colors.white),
        //       child: Column(children: [
        //         Text(
        //           "Select car to track",
        //           style: TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //               letterSpacing: 1,
        //               wordSpacing: .5,
        //               color: Colors.black),
        //         ),
        //       ]),
        //     ))
      ],
    );
  }

  Future<Position> userPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    GeolocatorAndroid.registerWith();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location services are permantently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
