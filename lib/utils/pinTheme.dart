import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:social_media_services/components/color_manager.dart';

final defaultPinTheme = PinTheme(
  width: 70,
  height: 67,
  textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(8),
      color: ColorManager.whiteColor,
      boxShadow: [
        BoxShadow(
          blurRadius: 10.0,
          color: Colors.grey.shade300,
          offset: const Offset(5, 8.5),
        ),
      ]),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  color: const Color(
      0xffe0fede), // border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);
