import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/utils/getLocalLanguage.dart';
import 'package:social_media_services/widgets/backbutton.dart';

class HowToWorkPage extends StatefulWidget {
  const HowToWorkPage({Key? key}) : super(key: key);

  @override
  HowToWorkPageState createState() => HowToWorkPageState();
}

class HowToWorkPageState extends State<HowToWorkPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, Routes.phoneNumber);
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(
      'assets/$assetName',
      width: width,
      height: 80,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getlocalLanguage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const bodyStyle = TextStyle(fontSize: 19.0);
    final str = AppLocalizations.of(context)!;

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            BackButton2(),
            Expanded(
              child: IntroductionScreen(
                key: introKey,
                globalBackgroundColor: Colors.white,
                allowImplicitScrolling: true,
                // autoScrollDuration: 3000,
                // infiniteAutoScroll: true,
                globalHeader: Align(
                  // alignment: Alignment.topRight,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 16),
                      child: SizedBox(
                          width: size.width * .6,
                          height: size.height * .25,
                          child: SvgPicture.asset(
                              'assets/logo/app_logo_shadow.svg')),
                    ),
                  ),
                ),
                globalFooter: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: size.width * .5,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        str.proceed,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => _onIntroEnd(context),
                    ),
                  ),
                ),

                rawPages: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * .25),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    // width: 250,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      str.how,
                                      softWrap: true,
                                      style: getBoldtStyle(
                                          color: ColorManager.black,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              str.how1,
                              style: getSemiBoldtStyle(
                                  color: ColorManager.grayDark, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              str.how1s,
                              style: getRegularStyle(
                                  color: ColorManager.serviceHomeGrey,
                                  fontSize: 13.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * .25),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    // width: 250,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      str.how2,
                                      softWrap: true,
                                      style: getSemiBoldtStyle(
                                          color: ColorManager.grayDark,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Expanded(
                          //   child: Container(
                          //     // width: 250,
                          //     child: Text(
                          //       textAlign: TextAlign.center,
                          //       str.how2,
                          //       softWrap: true,
                          //       style: getSemiBoldtStyle(
                          //           color: ColorManager.grayDark, fontSize: 18),
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 20),
                          //   child: Text(
                          //     str.how2,
                          //     style: getSemiBoldtStyle(
                          //         color: ColorManager.grayDark, fontSize: 18),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              str.how2s,
                              style: getRegularStyle(
                                  color: ColorManager.serviceHomeGrey,
                                  fontSize: 13.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * .25),
                      child: Column(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 25),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Expanded(
                          //         child: Container(
                          //           // width: 250,
                          //           child: Text(
                          //             textAlign: TextAlign.center,
                          //             str.how,
                          //             softWrap: true,
                          //             style: getBoldtStyle(
                          //                 color: ColorManager.black,
                          //                 fontSize: 18),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                child: Text(
                                  str.how3,
                                  style: getSemiBoldtStyle(
                                      color: ColorManager.grayDark,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              str.how3s,
                              style: getRegularStyle(
                                  color: ColorManager.serviceHomeGrey,
                                  fontSize: 13.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * .2),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                child: Text(
                                  str.how4,
                                  style: getSemiBoldtStyle(
                                      color: ColorManager.grayDark,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              str.how4s,
                              style: getRegularStyle(
                                  color: ColorManager.serviceHomeGrey,
                                  fontSize: 13.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * .25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                child: Text(
                                  str.how5,
                                  style: getSemiBoldtStyle(
                                      color: ColorManager.grayDark,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              str.how5s,
                              style: getRegularStyle(
                                  color: ColorManager.serviceHomeGrey,
                                  fontSize: 13.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                // pages: [

                //   PageViewModel(
                //     titleWidget: Text(
                //       str.how2,
                //       style: getSemiBoldtStyle(
                //           color: ColorManager.grayDark, fontSize: 20),
                //     ),
                //     bodyWidget: Text(
                //       str.how2s,
                //       style: getRegularStyle(
                //           color: ColorManager.serviceHomeGrey, fontSize: 14),
                //     ),
                //     image: Text(''),
                //     decoration: pageDecoration,
                //   ),
                //   PageViewModel(
                //     titleWidget: Text(
                //       str.how3,
                //       style: getSemiBoldtStyle(
                //           color: ColorManager.grayDark, fontSize: 20),
                //     ),
                //     bodyWidget: Text(
                //       str.how3s,
                //       style: getRegularStyle(
                //           color: ColorManager.serviceHomeGrey, fontSize: 14),
                //     ),
                //     image: Text(''),
                //     decoration: pageDecoration,
                //   ),
                //   PageViewModel(
                //       titleWidget: Text(
                //         str.how4,
                //         style: getSemiBoldtStyle(
                //             color: ColorManager.grayDark, fontSize: 20),
                //       ),
                //       bodyWidget: Text(
                //         str.how4s,
                //         style: getRegularStyle(
                //             color: ColorManager.serviceHomeGrey, fontSize: 14),
                //       ),
                //       image: Text(''),
                //       decoration: pageDecoration),
                //   PageViewModel(
                //       titleWidget: Text(
                //         str.how5,
                //         style: getSemiBoldtStyle(
                //             color: ColorManager.grayDark, fontSize: 20),
                //       ),
                //       bodyWidget: Text(
                //         str.how5s,
                //         style: getRegularStyle(
                //             color: ColorManager.serviceHomeGrey, fontSize: 14),
                //       ),
                //       image: Text(''),
                //       // reverse: true,
                //       decoration: pageDecoration),
                //   // PageViewModel(
                //   //   title: str.hw_mc_5,
                //   //   bodyWidget: Row(
                //   //     mainAxisAlignment: MainAxisAlignment.center,
                //   //     children: [
                //   //       Text("Click on ", style: bodyStyle),
                //   //       Icon(Icons.edit),
                //   //       Text(" to edit a post", style: bodyStyle),
                //   //     ],
                //   //   ),
                //   //   decoration: pageDecoration.copyWith(
                //   //     bodyFlex: 2,
                //   //     imageFlex: 4,
                //   //     bodyAlignment: Alignment.bottomCenter,
                //   //     imageAlignment: Alignment.topCenter,
                //   //   ),
                //   //   image: _buildImage('img1.jpg'),
                //   //   reverse: true,
                //   // ),
                // ],
                onDone: () => _onIntroEnd(context),
                onSkip: () =>
                    _onIntroEnd(context), // You can override onSkip callback
                showSkipButton: true,
                skipOrBackFlex: 0,
                nextFlex: 0,
                showBackButton: false,
                //rtl: true, // Display as right-to-left
                back: const Icon(Icons.arrow_back),
                skip: Text(str.skip,
                    style: TextStyle(fontWeight: FontWeight.w600)),
                next: const Icon(Icons.arrow_forward),
                done: Text(str.done,
                    style: TextStyle(fontWeight: FontWeight.w600)),
                curve: Curves.fastLinearToSlowEaseIn, dotsFlex: 2,
                controlsMargin: const EdgeInsets.all(16),
                controlsPadding: kIsWeb
                    ? const EdgeInsets.all(12.0)
                    : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                dotsDecorator: const DotsDecorator(
                  size: Size(10.0, 10.0),
                  color: Color(0xFFBDBDBD),
                  activeSize: Size(22.0, 10.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                dotsContainerDecorator: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
