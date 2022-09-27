import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';

import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/API/get_countries.dart';
import 'package:social_media_services/API/get_language.dart';
import 'package:social_media_services/main.dart';
import 'package:social_media_services/providers/data_provider.dart';
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

    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorManager.whiteColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [IntroductionLogo()],
        )));
  }

  gotoNextPage() async {
    getlocalLanguage();
    await getLanguageData(context);
    await getCountriesData(context);

    // loadImages();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.introductionScreen);
    });
  }

  Future<void> initPlatformState() async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    String? deviceId;

    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      provider.deviceId = deviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    gotoNextPage();
    print(provider.deviceId);
  }

  getlocalLanguage() {
    lang = Hive.box('LocalLan').get('lang', defaultValue: 'en');
    if (!mounted) return;
    MyApp.of(context).setLocale(
      Locale.fromSubtags(
        languageCode: lang,
      ),
    );
    print(lang);
    print("hiii");
  }

  // loadImages() async {
  //   final provider = Provider.of<DataProvider>(context, listen: false);
  //   final m =
  //       provider.countriesModel?.countries?.map((e) => e.countryflag).toList();
  //   final si = await ScalableImage.fromSvgHttpUrl(Uri.parse(
  //       'https://projects.techoriz.in/serviceapp/public/assets/uploads/countries_flag/bermuda.svg'));
  //   print('hi');
  //   provider.siImageData(si);
  // }
}
