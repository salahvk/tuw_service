// import 'package:flutter/material.dart';
// import 'package:social_media_services/components/color_manager.dart';

// class CustomRadioButton extends StatefulWidget {
//   // bool male;
//   String? gender;
//   // bool value;
//   CustomRadioButton({
//     Key? key,
//     this.gender,
//   }) : super(key: key);

//   @override
//   State<CustomRadioButton> createState() => _CustomRadioButtonState();
// }

// class _CustomRadioButtonState extends State<CustomRadioButton> {
//   bool isSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 5.0,
//               color: Colors.grey.shade400,
//               offset: const Offset(3, 3),
//             )
//           ],
//         ),
//         child: CircleAvatar(
//           radius: 9,
//           backgroundColor:
//               isSelected ? ColorManager.primary : ColorManager.whiteColor,
//           child: Radio(
//             fillColor: MaterialStateProperty.all(Colors.transparent),
//             visualDensity: const VisualDensity(
//               horizontal: VisualDensity.minimumDensity,
//               vertical: VisualDensity.minimumDensity,
//             ),
//             value: "Male",
//             overlayColor: MaterialStateProperty.all(ColorManager.primary),
//             groupValue: widget.gender,
//             onChanged: (value) {
//               setState(() {
//                 widget.gender = value.toString();
//                 isSelected = true;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
