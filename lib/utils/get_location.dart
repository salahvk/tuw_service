// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:social_media_services/API/updateLocation.dart';
import 'package:social_media_services/API/viewProfile.dart';

requestLocationPermission(BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permissions are denied');
    } else if (permission == LocationPermission.deniedForever) {
      print("'Location permissions are permanently denied");
    } else {
      print("GPS Location service is granted");
    }
  } else {
    print("GPS Location permission granted.");
  }
  // searchController.text.isEmpty ? getCurrentLocation() : null;
  final latLon = await getCurrentLocation();
  print('return');
  print(latLon);
  await updateLocationFunction(context, latLon, '');
  await viewProfile(context);
}

Future<List<double>> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  double latitude = position.latitude;
  double longitude = position.longitude;
  List<double> latLon = [];
  latLon.addAll([latitude, longitude]);

  return latLon;
}
