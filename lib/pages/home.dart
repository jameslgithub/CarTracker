import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? _position;

  void _getCurrentLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));

    setState(() {
      _position = LatLng(position.latitude, position.longitude);
      print(_position);
    });
    // changeposition(_position);
  }

  static changeposition(pos) {
    CameraPosition(
      target: pos,
      zoom: 14.4746,
    );
    print(pos);
  }

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
              _controller.complete(controller);
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _getCurrentLocation,
            label: const Text(''),
            icon: const Icon(Icons.add_circle),
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

  Future<Position> detPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }
    var curPos =
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return await curPos;
  }
}
