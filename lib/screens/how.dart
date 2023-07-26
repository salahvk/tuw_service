import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/utils/getLocalLanguage.dart';

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

    return IntroductionScreen(
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
                height: size.height * .3,
                child: SvgPicture.asset('assets/logo/app_logo_shadow.svg')),
          ),
        ),
      ),
      globalFooter: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: size.width * .5,
          height: 50,
          child: ElevatedButton(
            child: const Text(
              'Proceed',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          titleWidget: Text(
            str.hw_mc_1,
            style:
                getSemiBoldtStyle(color: ColorManager.grayDark, fontSize: 20),
          ),
          bodyWidget: Text(
            "Instead of having to buy an entire share, invest any amount you want.",
            style: getRegularStyle(
                color: ColorManager.serviceHomeGrey, fontSize: 14),
          ),
          image: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              // width: 250,
              child: Text(str.hw_title2,
                  softWrap: true,
                  style:
                      getBoldtStyle(color: ColorManager.black, fontSize: 20)),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            str.hw_mc_2,
            style:
                getSemiBoldtStyle(color: ColorManager.grayDark, fontSize: 20),
          ),
          bodyWidget: Text(
            "Download the Stockpile app and master the market with our mini-lesson.",
            style: getRegularStyle(
                color: ColorManager.serviceHomeGrey, fontSize: 14),
          ),
          image: _buildImage('1201.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            str.hw_mc_3,
            style:
                getSemiBoldtStyle(color: ColorManager.grayDark, fontSize: 20),
          ),
          bodyWidget: Text(
            "Kids and teens can track their stocks 24/7 and place trades that you approve.",
            style: getRegularStyle(
                color: ColorManager.serviceHomeGrey, fontSize: 14),
          ),
          image: _buildImage('1201.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
            titleWidget: Text(
              str.hw_mc_4,
              style:
                  getSemiBoldtStyle(color: ColorManager.grayDark, fontSize: 20),
            ),
            bodyWidget: Text(
              "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
              style: getRegularStyle(
                  color: ColorManager.serviceHomeGrey, fontSize: 14),
            ),
            image: _buildImage('1201.png'),
            decoration: pageDecoration),
        PageViewModel(
            titleWidget: Text(
              str.hw_mc_5,
              style:
                  getSemiBoldtStyle(color: ColorManager.grayDark, fontSize: 20),
            ),
            bodyWidget: Text(
              "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
              style: getRegularStyle(
                  color: ColorManager.serviceHomeGrey, fontSize: 14),
            ),
            image: _buildImage('1201.png'),
            // reverse: true,
            decoration: pageDecoration),
        // PageViewModel(
        //   title: str.hw_mc_5,
        //   bodyWidget: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text("Click on ", style: bodyStyle),
        //       Icon(Icons.edit),
        //       Text(" to edit a post", style: bodyStyle),
        //     ],
        //   ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 2,
        //     imageFlex: 4,
        //     bodyAlignment: Alignment.bottomCenter,
        //     imageAlignment: Alignment.topCenter,
        //   ),
        //   image: _buildImage('img1.jpg'),
        //   reverse: true,
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
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
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.black87,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }
}
