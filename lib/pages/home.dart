import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(40.7533, -73.9904);
  static const LatLng destination = LatLng(40.7536, -73.9850);

  Set<Polyline> _polylines = Set<Polyline>();
  LocationData? currentLocation;
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyD2tCcVQU5PsN2Hsr4im8FZY-NxeUWov0A",
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.walking);
    if (result.status == 'OK') {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    }
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    location.changeSettings(
        accuracy: LocationAccuracy.high, interval: 1, distanceFilter: 0.1);
    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 17,
              target: LatLng(newLoc.latitude!, newLoc.longitude!),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    getCurrentLocation();
    polylinePoints = PolylinePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome Back",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.normal,

              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 30,
              ),
              padding: EdgeInsets.only(
                top: 40.0,
              ),
              polylines: _polylines,
              // {
              //   Polyline(
              //     polylineId: PolylineId("route"),
              //     points: polylineCoordinates,
              //     color: Color(0xFF674AEF),
              //     width: 5,
              //   ),
              // },
              markers: {
                const Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                ),
                // Marker(
                //   markerId: MarkerId("currentLocation"),
                //   position: LatLng(
                //       currentLocation!.latitude!, currentLocation!.longitude!),
                // ),
                const Marker(
                  markerId: MarkerId("destination"),
                  position: destination,
                )
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);

                getPolyPoints();
              },
            ),
    );
  }
}
