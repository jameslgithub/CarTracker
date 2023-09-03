import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

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
            onPressed: addCar,
            label: const Text('Add car'),
            icon: const Icon(Icons.add_circle),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(children: [
                Text(
                  "Select car to track",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      wordSpacing: .5,
                      color: Colors.black),
                ),
              ]),
            ))
      ],
    );
  }

  Future<void> addCar() async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              ListTile(
                title: Text("Car brand"),
              )
            ],
          );
        });
  }
}
