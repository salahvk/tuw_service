import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mini;
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({
    Key? key,
    required this.mini,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  // screen sizes
  static bool isMini(BuildContext context) =>
      MediaQuery.of(context).size.height < 600;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.height > 600 &&
      MediaQuery.of(context).size.height <= 1000;

  // static bool isTablet(BuildContext context) =>
  //     MediaQuery.of(context).size.width < 1000 &&
  //     MediaQuery.of(context).size.width >= 600;

  // static bool isDesktop(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= 1000;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight >= 1000) {
          return desktop;
        } else if (constraints.maxHeight >= 600) {
          return mobile;
        } else if (constraints.maxHeight >= 400) {
          return mini;
        } else {
          return mini;
        }
      },
    );
  }
}
