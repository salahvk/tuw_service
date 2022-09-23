import 'dart:async';

import 'package:flutter/material.dart';

import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/providers/get_countries.dart';
import 'package:social_media_services/providers/get_language.dart';
import 'package:social_media_services/widgets/introduction_logo.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool loading = true;
  @override
  void initState() {
    super.initState();
    gotoNextPage();
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
    await getLanguageData(context);
    await getCountriesData(context);
    // loadImages();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.introductionScreen);
    });
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
