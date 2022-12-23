// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/updateLocation.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/API/view_chat_messages.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/servicer_provider.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:http/http.dart' as http;

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

sendCurrentLocation(
  BuildContext context,
) async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      log('Location permissions are denied');
    } else if (permission == LocationPermission.deniedForever) {
      log("'Location permissions are permanently denied");
      showAnimatedSnackBar(context, 'Enable Location for further access');
    } else {
      log("GPS Location service is granted");
    }
  } else {
    log("GPS Location permission granted.");
    final latLon = await getCurrentLocation();
    // final location = await getPlaceAddress(latLon);
    final latlonString = "${latLon[0]},${latLon[1]}";
    print(latlonString);
    sendLocation(
      context,
      latlonString,
    );
  }
  // searchController.text.isEmpty ? getCurrentLocation() : null;
}

sendLocation(context, String latLon) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  final receiverId = provider.serviceManDetails?.userData?.id.toString();
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');
  final url =
      '$api/chat-store?receiver_id=$receiverId&type=location&message=$latLon&page=1';

  print(url);
  if (apiToken == null) return;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      final servicerProvider =
          Provider.of<ServicerProvider>(context, listen: false);

      log("Location send");
      viewChatMessages(context, servicerProvider.servicerId);
    } else {
      showAnimatedSnackBar(context, "The Message can't be sent at the Moment");
    }
  } on Exception catch (e) {
    log("Something Went Wrong1");
    showAnimatedSnackBar(context, "The Message can't be sent at the Moment");
    print(e);
  }
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
