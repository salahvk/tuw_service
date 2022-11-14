// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:provider/provider.dart';
// import 'package:social_media_services/API/updateLocation.dart';
// import 'package:social_media_services/components/color_manager.dart';
// import 'package:social_media_services/providers/data_provider.dart';
// import 'package:social_media_services/screens/Address%20page/address_page.dart';

// class CustomizeMarkerExample extends StatefulWidget {
//   @override
//   State<CustomizeMarkerExample> createState() => _CustomizeMarkerExampleState();
// }

// class _CustomizeMarkerExampleState extends State<CustomizeMarkerExample> {
//   double? latitude;
//   double? longitude;
//   TextEditingController searchController = TextEditingController();
//   final mapController = MapController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     searchController.text = '';

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DataProvider>(context, listen: false);
//     final userDetails = provider.viewProfileModel?.userdetails;

//     return Scaffold(
//       bottomNavigationBar: searchController.text.isNotEmpty
//           ? ElevatedButton(
//               onPressed: () {
//                 updateLocationFunction(context, [latitude, longitude]);
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (ctx) {
//                   return const AddressPage();
//                 }));
//               },
//               child: const Text('Confirm New Location'))
//           : null,
//       appBar: AppBar(
//         backgroundColor: ColorManager.primary,
//         title: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
//           child: TextField(
//             controller: searchController,
//             decoration: InputDecoration(
//                 suffixIcon: InkWell(
//               child: const Icon(Icons.search),
//               onTap: () async {
//                 await searchLocation();
//                 setState(() {});
//               },
//             )),
            // onChanged: (value) {
            //   searchLocation();
            // },
//           ),
//         ),
        // title: InkWell(
        //     onTap: () async {
        //       Position position = await Geolocator.getCurrentPosition(
        //           desiredAccuracy: LocationAccuracy.high);
        //       print(position.longitude); //Output: 80.24599079
        //       print(position.latitude); //Output: 29.6593457
        //     },
        //     child: const Text('Your Location')),
//       ),
//       body: Column(
//         children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     onChanged: (value) {
          //       searchLocation();
          //     },
          //   ),
          // ),

//           Expanded(
//             child: FlutterMap(
//               mapController: mapController,
//               options: MapOptions(
//                 center: LatLng(double.parse(userDetails?.latitude ?? ''),
//                     double.parse(userDetails?.longitude ?? '')),
//                 zoom: 11,
//                 maxZoom: 19,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   subdomains: const ['a', 'b', 'c'],
//                   userAgentPackageName:
//                       'net.tlserver6y.flutter_map_location_marker.example',
//                   maxZoom: 19,
//                 ),
                // CurrentLocationLayer(
                //   centerOnLocationUpdate: CenterOnLocationUpdate.never,
                //   style: const LocationMarkerStyle(
                //     marker: DefaultLocationMarker(
                //       color: ColorManager.primary2,
                //       child: Icon(
                //         Icons.person,
                //         color: Colors.white,
                //         size: 30,
                //       ),
                //     ),
                //     markerSize: Size(40, 40),
                //     accuracyCircleColor: ColorManager.primary2,
                //     headingSectorColor: ColorManager.primary,
                //     headingSectorRadius: 120,
                //   ),
                //   // moveAnimationDuration: Duration.zero, // disable animation
                // ),
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       point: LatLng(latitude ?? 0, longitude ?? 0),
//                       width: 30,
//                       height: 30,
//                       builder: (context) => const CircleAvatar(
//                         radius: 2,
//                         backgroundColor: ColorManager.primary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   searchLocation() async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     List<Location> locations = await locationFromAddress(searchController.text);

//     setState(() {
//       latitude = locations[0].latitude;
//       longitude = locations[0].longitude;
//     });
//     mapController.move(LatLng(latitude ?? 0, longitude ?? 0), 5);
//     // print(longitude);
//     print(locations);
//   }
// }
