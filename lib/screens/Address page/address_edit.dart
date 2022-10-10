import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/custom/links.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_service_page.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/mandatory_widget.dart';
import 'package:social_media_services/widgets/profile_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserAddressEdit extends StatefulWidget {
  const UserAddressEdit({super.key});

  @override
  State<UserAddressEdit> createState() => _UserAddressEditState();
}

class _UserAddressEditState extends State<UserAddressEdit> {
  String? selectedValue;
  int _selectedIndex = 2;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];
  String lang = '';
  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<DataProvider>(context, listen: true);
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
                          ProfileImage(
                            isNavigationActive: true,
                            iconSize: 12,
                            profileSize: 40.5,
                            iconRadius: 12,
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
                                            str.ae_home_locator,
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
                                str.ae_address,
                                style: getBoldtStyle(
                                    color: ColorManager.black, fontSize: 14),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius: BorderRadius.circular(5)),

                                // width: 30,
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
                                        str.ae_add,
                                        style: getRegularStyle(
                                            color: ColorManager.whiteColor),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          MandatoryHeader(heading: str.ae_address_n),
                          TextFieldProfileService(hintText: str.ae_address_h),
                          MandatoryHeader(heading: str.ae_address),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.grey.shade300,
                                    // offset: const Offset(5, 8.5),
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                child: TextField(
                                  minLines: 4,
                                  maxLines: 5,
                                  style: const TextStyle(),
                                  // controller: aboutController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      hintText: str.ae_address_h,
                                      hintStyle: getRegularStyle(
                                          color: const Color.fromARGB(
                                              255, 173, 173, 173),
                                          fontSize: 15)),
                                ),
                              ),
                            ),
                          ),
                          MandatoryHeader(heading: str.ae_country),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.grey.shade300,
                                    // offset: const Offset(5, 8.5),
                                  ),
                                ],
                              ),
                              child: Container(
                                width: size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: ColorManager.whiteColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 35,
                                        color: ColorManager.black,
                                      ),
                                      hint: Text(str.ae_country_h,
                                          style: getRegularStyle(
                                              color: const Color.fromARGB(
                                                  255, 173, 173, 173),
                                              fontSize: 15)),
                                      items: items
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item,
                                                    style: getRegularStyle(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: 15)),
                                              ))
                                          .toList(),
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value as String;
                                        });
                                      },
                                      buttonHeight: 40,
                                      // buttonWidth: 140,
                                      itemHeight: 40,
                                      buttonPadding: const EdgeInsets.fromLTRB(
                                          12, 0, 8, 0),
                                      // dropdownWidth: size.width,
                                      itemPadding: const EdgeInsets.fromLTRB(
                                          12, 0, 12, 0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ), // * Region
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MandatoryHeader(heading: str.ae_region),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Container(
                                      width: size.width * .44,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.grey.shade300,
                                            // offset: const Offset(5, 8.5),
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        style: const TextStyle(),
                                        // controller: regionController,
                                        decoration: InputDecoration(
                                            hintText: str.ae_region_h,
                                            hintStyle: getRegularStyle(
                                                color: const Color.fromARGB(
                                                    255, 173, 173, 173),
                                                fontSize: 15)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MandatoryHeader(heading: str.ae_state),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Container(
                                      width: size.width * .44,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.grey.shade300,
                                            // offset: const Offset(5, 8.5),
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        style: const TextStyle(),
                                        // controller: stateController,
                                        decoration: InputDecoration(
                                            hintText: str.ae_state_h,
                                            hintStyle: getRegularStyle(
                                                color: const Color.fromARGB(
                                                    255, 173, 173, 173),
                                                fontSize: 15)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          MandatoryHeader(heading: str.ae_home_flat),
                          TextFieldProfileService(hintText: str.ae_no),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      // player.stop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 0)),
                                    child: Text(
                                      str.ae_save,
                                      style: getMediumtStyle(
                                          color: ColorManager.whiteText,
                                          fontSize: 14),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 0)),
                                    child: Text(
                                      str.ae_cancel,
                                      style: getMediumtStyle(
                                          color: ColorManager.whiteText,
                                          fontSize: 14),
                                    ))
                              ],
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
