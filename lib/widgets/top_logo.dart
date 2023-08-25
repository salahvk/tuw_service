import 'package:flutter/material.dart';

class TopLogo extends StatelessWidget {
  TopLogo();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(0xff08dc2c),
      child: Image.asset(
        'assets/logo/app-logo-T.jpg',
        height: 30,
        width: 30,
      ),
    );
  }
}
