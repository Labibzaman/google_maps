import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Location location = Location();
  LocationData? currentLocation;
  LocationData? myLocation;
  late StreamSubscription locationSubscription;

  void listentoLocation() {
    locationSubscription = location.onLocationChanged.listen((locationData) {
      myLocation = locationData;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listentoLocation();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Location'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('My Location${currentLocation?.latitude ?? ''} ${currentLocation?.longitude ?? ''}'),
          Text('My Location${myLocation?.latitude ?? ''} ${myLocation?.longitude ?? ''}'),
          ElevatedButton(
            onPressed: () async {
              currentLocation = await location.getLocation();
              print(currentLocation?.longitude);
              print(currentLocation?.latitude);
              print(currentLocation?.altitude);
              if (mounted) {
                setState(() {});
              }
            },
            child: const Text('Get Locaton'),
          ),
          Text('Has Permission'),
          ElevatedButton(
            onPressed: () async {
              PermissionStatus status = await location.hasPermission();
              if (status == PermissionStatus.denied ||
                  status == PermissionStatus.deniedForever) {
                await location.requestPermission();
                await location.getLocation();
              }
            },
            child: Text('Give permission'),
          ),
        ],
      ),
    );
  }
}
