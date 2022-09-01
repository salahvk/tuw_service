import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class TroubleSign extends StatelessWidget {
  const TroubleSign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: Icon(
              Icons.email,
              color: ColorManager.primary,
            ),
          ),
          Text('Trouble Signing In?',
              style: getRegularStyle(
                  color: const Color(0xff9f9f9f), fontSize: 15)),
          Text(' Login with an email',
              style:
                  getRegularStyle(color: ColorManager.primary, fontSize: 15)),
        ],
      ),
    );
  }
}
