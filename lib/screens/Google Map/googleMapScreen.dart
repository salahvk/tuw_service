// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/updateLocation.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/Address%20page/address_page.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng? _lastTap;
  bool isLocationChanged = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final userDetails = provider.viewProfileModel?.userdetails;
    final currentLocator = LatLng(
        double.parse(userDetails?.latitude ?? '41.612849'),
        double.parse(userDetails?.longitude ?? '13.046816'));

    return Scaffold(
      bottomNavigationBar: isLocationChanged
          ? ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await updateLocationFunction(
                    context, [_lastTap?.latitude, _lastTap?.longitude]);
                setState(() {
                  isLoading = false;
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) {
                  return const AddressPage();
                }));
              },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Confirm New Location'))
          : null,
      body: GoogleMap(
        myLocationEnabled: true,
        onTap: (LatLng pos) {
          setState(() {
            _lastTap = pos;
          });
          if (pos != currentLocator) {
            setState(() {
              isLocationChanged = true;
            });
          }
          print(_lastTap);
        },
        initialCameraPosition: CameraPosition(
          target: currentLocator,
          zoom: 11.0,
        ),
        markers: <Marker>{
          Marker(
            markerId: const MarkerId('test_marker_id'),
            position: _lastTap ?? currentLocator,
            infoWindow: const InfoWindow(
              title: 'An interesting location',
              snippet: '*',
            ),
          ),
        },
        // gestureRecognizers: <
        //     Factory<OneSequenceGestureRecognizer>>{
        //   Factory<OneSequenceGestureRecognizer>(
        //     () => ScaleGestureRecognizer(),
        //   ),
        // },
        gestureRecognizers: //
            <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
      ),
    );
  }
}
