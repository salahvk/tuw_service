import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initPlatformState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    // InternetConnectionChecker().onStatusChange.listen((status) {
    //   switch (status) {
    //     case InternetConnectionStatus.connected:
    //       provider.isInternetConnected = true;

    //       break;
    //     case InternetConnectionStatus.disconnected:
    //       provider.isInternetConnected = false;

    //       break;
    //   }
    // });
    return Scaffold(
        backgroundColor: ColorManager.whiteColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [IntroductionLogo()],
        )));
  }
}
