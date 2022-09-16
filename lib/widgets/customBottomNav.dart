// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:social_media_services/components/color_manager.dart';

// class CustomBottomBar extends StatefulWidget {
//   int selectedIndex;
//   CustomBottomBar({super.key, required this.selectedIndex});

//   @override
//   State<CustomBottomBar> createState() => _CustomBottomBarState();
// }

// class _CustomBottomBarState extends State<CustomBottomBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: 72,
//           decoration: BoxDecoration(boxShadow: [
//             BoxShadow(
//               blurRadius: 5.0,
//               color: Colors.grey.shade400,
//               offset: const Offset(6, 1),
//             ),
//           ]),
//           child: GNav(
//             // rippleColor: Colors.grey[300]!,
//             // hoverColor: ColorManager.errorRed,
//             tabMargin: const EdgeInsets.symmetric(
//               vertical: 13,
//             ),
//             gap: 0,
//             backgroundColor: ColorManager.whiteColor,
//             mainAxisAlignment: MainAxisAlignment.center,
//             activeColor: ColorManager.grayDark,
//             iconSize: 24,
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
//             duration: const Duration(milliseconds: 400),
//             tabBackgroundColor: ColorManager.primary.withOpacity(0.4),

//             color: ColorManager.black,
//             tabs: const [
//               GButton(
//                 icon: Icons.home,
//                 // text: 'Home',
//               ),
//               GButton(
//                 icon: FontAwesomeIcons.message,
//                 // text: 'Message',
//               ),
//               // GButton(
//               //   icon: Icons.music_note_sharp,
//               //   text: 'Music',
//               // ),
//               // GButton(
//               //   icon: Icons.person,
//               //   text: 'Profile',
//               // ),
//               // GButton(
//               //   icon: Icons.home,
//               //   text: 'Home',
//               // ),
//             ],
//             selectedIndex: widget.selectedIndex,
//             onTabChange: (index) {
//               setState(() {
//                 widget.selectedIndex = index;
//               });
//             },
//           ),
//         ),
//         Positioned(
//             right: 5,
//             bottom: 14,
//             child: Builder(
//               builder: (context) => InkWell(
//                 onTap: () {
//                   Scaffold.of(context).openEndDrawer();
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Icon(
//                     Icons.menu,
//                     size: 25,
//                     color: ColorManager.black,
//                   ),
//                 ),
//               ),
//             ))
//       ],
//     );
//   }
// }
