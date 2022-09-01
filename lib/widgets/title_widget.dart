import 'package:flutter/material.dart';
import 'package:social_media_services/components/styles_manager.dart';

class TitleWidget extends StatelessWidget {
  final String name;
  const TitleWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(name,
        style: getRegularStyle(
            color: const Color.fromARGB(255, 146, 145, 145), fontSize: 15));
  }
}
