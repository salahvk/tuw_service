import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:social_media_services/components/color_manager.dart';

class CustomizeMarkerExample extends StatefulWidget {
  @override
  State<CustomizeMarkerExample> createState() => _CustomizeMarkerExampleState();
}

class _CustomizeMarkerExampleState extends State<CustomizeMarkerExample> {
  double? latitude;
  double? longitude;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    requestPermission();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () async {
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              print(position.longitude); //Output: 80.24599079
              print(position.latitude); //Output: 29.6593457
            },
            child: const Text('Your Location')),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(latitude ?? 24.774265, longitude ?? 46.738586),
          zoom: 11,
          maxZoom: 19,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName:
                'net.tlserver6y.flutter_map_location_marker.example',
            maxZoom: 19,
          ),
          CurrentLocationLayer(
            centerOnLocationUpdate: CenterOnLocationUpdate.always,
            style: const LocationMarkerStyle(
              marker: DefaultLocationMarker(
                color: ColorManager.primary2,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              markerSize: Size(40, 40),
              accuracyCircleColor: ColorManager.primary2,
              headingSectorColor: ColorManager.primary,
              headingSectorRadius: 120,
            ),
            // moveAnimationDuration: Duration.zero, // disable animation
          ),
        ],
      ),
    );
  }

  requestPermission() async {
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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    longitude = position.longitude;
    latitude = position.latitude;
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457
  }
}
