// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/updateLocation.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
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
  String? locality;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final userDetails = provider.viewProfileModel?.userdetails;
    final currentLocator = LatLng(
        double.parse(userDetails?.latitude ?? '41.612849'),
        double.parse(userDetails?.longitude ?? '13.046816'));

    return Scaffold(
      bottomNavigationBar: isLocationChanged
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await updateLocationFunction(
                        context,
                        [_lastTap?.latitude, _lastTap?.longitude],
                        locality ?? '');
                    await viewProfile(context);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) {
                      return const AddressPage();
                    }));
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Confirm New Location')),
            )
          : null,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GoogleMap(
            myLocationEnabled: true,
            // compassEnabled: true,

            onTap: (LatLng pos) async {
              setState(() {
                _lastTap = pos;
              });
              if (pos != currentLocator) {
                setState(() {
                  isLocationChanged = true;
                });
              }
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(pos.latitude, pos.longitude);
              // print(_lastTap);
              // print(placemarks);
              if (placemarks[0].subLocality!.isNotEmpty) {
                setState(() {
                  locality =
                      '${placemarks[0].subLocality == '' ? placemarks[1].name : placemarks[0].locality} | ${placemarks[0].country}';
                });
              } else if (placemarks[0].locality!.isNotEmpty) {
                setState(() {
                  locality =
                      '${placemarks[0].locality == '' ? placemarks[1].name : placemarks[0].locality} | ${placemarks[0].country}';
                });
              } else if (placemarks[0].name!.isNotEmpty) {
                setState(() {
                  locality =
                      '${placemarks[0].name == '' ? placemarks[1].name : placemarks[0].locality} | ${placemarks[0].country}';
                });
              }
              // print(placemarks[0].subLocality?.length == 0 ? placemarks[0].locality :);

              // setState(() {
              //   locality =
              //       '${placemarks[0].locality == '' ? placemarks[1].name : placemarks[0].locality} | ${placemarks[0].country}';
              // });
              // print(locality);
              // print(placemarks[0].country);
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
                  title: 'Home locator',
                  snippet: '*',
                ),
              ),
            },
            gestureRecognizers: //
                <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
          ),
          isLocationChanged
              ? Positioned(
                  // left: size.width * .3,
                  bottom: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    width: size.width * .43,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 45, child: Text(locality ?? '')),
                          SizedBox(
                            height: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${_lastTap?.latitude.toString().substring(0, 8)}, ',
                                  style: getSemiBoldtStyle(
                                      color: ColorManager.blue, fontSize: 12),
                                ),
                                Text(
                                  _lastTap?.longitude
                                          .toString()
                                          .substring(0, 8) ??
                                      '',
                                  style: getSemiBoldtStyle(
                                      color: ColorManager.blue, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }
}
