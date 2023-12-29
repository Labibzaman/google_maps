import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = Location();
  LocationData? myLocation;
  late StreamSubscription locationSubscription;
  late GoogleMapController googleMapController;

  LocationData? locationData;

  Future<void> getCurrentLocation() async {
    locationData = await location.getLocation();
    if (locationData == null) {
      return;
    }
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(locationData!.latitude!, locationData!.longitude!),
          zoom: 17,
        ),
      ),
    );
  }

  Future<void> getRealTimeLocation() async {
    locationSubscription =
    await location.onLocationChanged.listen((locationData) {
      myLocation = locationData;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getRealTimeLocation().then((_) {
      getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String MyLocationWindow =
        '(${myLocation?.latitude ?? 0}, ${myLocation?.longitude ?? 0})';

    Set<Polyline> polylines = {};

    if (myLocation != null && locationData != null) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('My Location Route'),
          points: [
            LatLng(myLocation!.latitude!, myLocation!.longitude!),
            LatLng(locationData!.latitude!, locationData!.longitude!),
          ],
          color: Colors.blue,
          width: 4,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 17,
          target: LatLng(myLocation?.latitude ?? 0, myLocation?.longitude ?? 0),
        ),
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
          getCurrentLocation();
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId('initialPosition'),
            position: LatLng(myLocation?.latitude ?? 0, myLocation?.longitude ?? 0),
            infoWindow: InfoWindow(
              title: 'My Current Location',
              snippet: MyLocationWindow,
            ),
            draggable: false,
            onTap: () {
              print('position');
            },
          ),
        },
        polylines: polylines,
      ),
    );
  }
}
