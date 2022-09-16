import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_services/Remaining%20pages/user_address_page.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/payment_custom_listTile.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  int _selectedIndex = 2;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];
  final player = AudioPlayer();
  bool isProgress = true;

  paySuccessSound() async {
    final duration = await player.setAsset('assets/Gpay.mp3');
  }

  @override
  void initState() {
    super.initState();
    paySuccessSound();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isProgress = false;
      });
      player.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawer: SizedBox(
        height: size.height * 0.825,
        width: size.width * 0.6,
        child: const CustomDrawer(),
      ),
      // * Custom bottom Nav
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Colors.grey.shade400,
                offset: const Offset(6, 1),
              ),
            ]),
          ),
          SizedBox(
            height: 44,
            child: GNav(
              tabMargin: const EdgeInsets.symmetric(
                vertical: 0,
              ),
              gap: 0,
              backgroundColor: ColorManager.whiteColor,
              mainAxisAlignment: MainAxisAlignment.center,
              activeColor: ColorManager.grayDark,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: ColorManager.primary.withOpacity(0.4),
              color: ColorManager.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                ),
              ],
              haptic: true,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          Positioned(
              right: 5,
              bottom: 0,
              child: Builder(
                builder: (context) => InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.menu,
                      size: 25,
                      color: ColorManager.black,
                    ),
                  ),
                ),
              ))
        ],
      ),
      body: _selectedIndex != 2
          ? _screens[_selectedIndex]
          : SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isProgress
                        ? const SizedBox(
                            height: 280,
                            width: 280,
                            child: Center(
                              child: SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: CircularProgressIndicator(
                                    backgroundColor: ColorManager.primary,
                                    color: ColorManager.whiteColor,
                                    strokeWidth: 5,
                                  )),
                            ))
                        : SizedBox(
                            height: 280,
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                LottieBuilder.asset(
                                  // fit: BoxFit.fitWidth,
                                  ImageAssets.paymentSuccess,
                                  repeat: false,
                                ),
                                Positioned(
                                    bottom: 20,
                                    // left: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Payment Successfull",
                                          style: getBoldtStyle(
                                              color: ColorManager.primary,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Transaction no : #123456789",
                                          style: getRegularStyle(
                                              color: ColorManager
                                                  .paymentPageColor1,
                                              fontSize: 16),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                    Text(
                      "Your payment was successfully processed.\nDetail of transaction are included",
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                          color: ColorManager.paymentPageColor1, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const PaymentListTile(text1: 'Date :', text2: '25/08/2022'),
                    const PaymentListTile(
                        text1: "Service Fee :", text2: "\$135.00 OMR"),
                    const PaymentListTile(
                        text1: 'Discount', text2: '\$7.00 OMR = 5%'),
                    const PaymentListTile(
                      text1: 'VAT',
                      text2: '\$12.00 OMR = 8%',
                    ),
                    const PaymentListTile(
                      text1: 'Mobile No :',
                      text2: '+968 9526 123456',
                    ),
                    const PaymentListTile(
                      text1: 'Exp Date :',
                      text2: '25/09/2022',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return const UserAddressPage();
                              }));
                              // player.stop();
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(13, 0, 13, 0)),
                            child: Text(
                              "BACK TO HOME",
                              style: getMediumtStyle(
                                  color: ColorManager.whiteText, fontSize: 14),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              print("Save pdf");
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(13, 0, 13, 0)),
                            child: Text(
                              "SAVE PDF",
                              style: getMediumtStyle(
                                  color: ColorManager.whiteText, fontSize: 14),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
