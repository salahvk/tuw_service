import 'package:flutter/material.dart';

class ResponsiveWidth extends StatelessWidget {
  final Widget mini;
  final Widget sMobile;
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const ResponsiveWidth({
    Key? key,
    required this.mini,
    required this.sMobile,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  // screen sizes
  static bool isMini(BuildContext context) =>
      MediaQuery.of(context).size.width < 360;

  static bool issMobile(BuildContext context) =>
      MediaQuery.of(context).size.width > 360 &&
      MediaQuery.of(context).size.width <= 400;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width > 400 &&
      MediaQuery.of(context).size.width <= 600;

  // static bool isTablet(BuildContext context) =>
  //     MediaQuery.of(context).size.width < 1000 &&
  //     MediaQuery.of(context).size.width >= 600;

  // static bool isDesktop(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= 1000;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1000) {
          return desktop;
        } else if (constraints.maxWidth >= 400) {
          return mobile;
        } else if (constraints.maxWidth >= 360) {
          return sMobile;
        } else if (constraints.maxWidth >= 320) {
          return mini;
        } else {
          return mini;
        }
      },
    );
  }
}
