import 'package:flutter/material.dart';

import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/utils/initPlatformState.dart';
import 'package:social_media_services/widgets/introduction_logo.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool loading = true;
  String lang = '';
  @override
  void initState() {
    super.initState();
    // Hive.box("token").clear();

    initPlatformState(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.whiteColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [IntroductionLogo()],
        )));
  }
}
