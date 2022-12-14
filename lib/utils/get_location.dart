// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:social_media_services/API/updateLocation.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';

requestLocationPermission(
  BuildContext context,
) async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permissions are denied');
    } else if (permission == LocationPermission.deniedForever) {
      print("'Location permissions are permanently denied");
      showAnimatedSnackBar(context, 'Enable Location for further access');
    } else {
      print("GPS Location service is granted");
    }
  } else {
    print("GPS Location permission granted.");
    final latLon = await getCurrentLocation();
    final location = await getPlaceAddress(latLon);
    await updateLocationFunction(
      context,
      latLon,
      location,
    );
    await viewProfile(context);
  }
  // searchController.text.isEmpty ? getCurrentLocation() : null;
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

Future<String> getPlaceAddress(List<double> latLon) async {
  String locationAddress = '';
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLon[0], latLon[1]);

    locationAddress = getLocationName(placemarks);
  } catch (error) {
    print(error);
  }
  return locationAddress;
}

String getLocationName(List<Placemark> placemarks) {
  String locality = '';
  if (placemarks[0].subLocality!.isNotEmpty) {
    locality = '${placemarks[0].subLocality} | ${placemarks[0].country}';
  } else if (placemarks[0].locality!.isNotEmpty) {
    locality = '${placemarks[0].locality} | ${placemarks[0].country}';
  } else if (placemarks[0].street!.isNotEmpty) {
    locality = '${placemarks[0].street} | ${placemarks[0].country}';
  } else if (placemarks[0].subAdministrativeArea!.isNotEmpty) {
    locality =
        '${placemarks[0].subAdministrativeArea} | ${placemarks[0].country}';
  } else if (placemarks[0].administrativeArea!.isNotEmpty) {
    locality = '${placemarks[0].administrativeArea} | ${placemarks[0].country}';
  } else if (placemarks[0].name!.isNotEmpty) {
    locality = '${placemarks[0].name} | ${placemarks[0].country}';
  } else {}
  print(locality);
  return locality;
}
