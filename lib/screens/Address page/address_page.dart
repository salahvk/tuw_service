import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/Address%20page/address_edit.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/custom/links.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/screens/worker_admin.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/profile_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int _selectedIndex = 2;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];
  String lang = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: false);
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
                tabs: [
                  GButton(
                    icon: FontAwesomeIcons.message,
                    leading: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(ImageAssets.homeIconSvg),
                    ),
                  ),
                  GButton(
                    icon: FontAwesomeIcons.message,
                    leading: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(ImageAssets.chatIconSvg),
                    ),
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
                left: lang == 'ar' ? 5 : null,
                right: lang != 'ar' ? 5 : null,
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
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return const WorkerDetailedAdmin();
                              }));
                            },
                            // * ProfileImage
                            child: ProfileImage(
                              isNavigationActive: true,
                              iconSize: 12,
                              profileSize: 40.5,
                              iconRadius: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            provider.viewProfileModel?.userdetails?.name ?? '',
                            style: getBoldtStyle(
                                color: ColorManager.black, fontSize: 13),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "PrithvinaRaj@gmail.com",
                            style: getRegularStyle(
                                color: ColorManager.grayLight, fontSize: 13),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "+967 123 456 789",
                            style: getRegularStyle(
                                color: ColorManager.grayLight, fontSize: 13),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: SizedBox(
                                height: 100,
                                width: size.width,
                                child: CachedNetworkImage(
                                  imageUrl: houseImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Oman | Sohar"),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(5)),

                                    // width: 30,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 2, 5, 5),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: ColorManager.whiteColor,
                                          ),
                                          Text(
                                            str.a_home_locator,
                                            style: getRegularStyle(
                                                color: ColorManager.whiteColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 14),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: SizedBox(
                                height: 100,
                                width: size.width,
                                child: CachedNetworkImage(
                                  imageUrl: googleMap,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                str.a_address,
                                style: getBoldtStyle(
                                    color: ColorManager.black, fontSize: 14),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius: BorderRadius.circular(5)),

                                // width: 30,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (ctx) {
                                      return const UserAddressEdit();
                                    }));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: ColorManager.whiteColor,
                                        ),
                                        Text(
                                          str.a_add,
                                          style: getRegularStyle(
                                              color: ColorManager.whiteColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                Text(
                                  str.a_home,
                                  style: getRegularStyle(
                                      color: ColorManager.grayLight),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: ColorManager.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.grey.shade300,
                                  offset: const Offset(5, 8.5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 20),
                              child: Text(
                                "Knowledge Oasis Muscat\nRusayl Housing Complex \nP.O Box:308, PC 124\nMuscat, Sultanate of Oman",
                                style: getRegularStyle(
                                    color: ColorManager.grayLight,
                                    fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
