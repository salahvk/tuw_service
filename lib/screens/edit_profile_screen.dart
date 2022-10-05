import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/animatedSnackBar.dart';
import 'package:social_media_services/widgets/customRadioButton.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/profile_image.dart';
import 'package:social_media_services/widgets/title_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<EditProfileScreen> {
  DateTime selectedDate = DateTime.now();
  bool value = true;
  bool isPickerSelected = false;

  FocusNode nfocus = FocusNode();
  FocusNode dobfocus = FocusNode();

  int _selectedIndex = 2;
  Timer? _debounce;

  String lang = '';
  String? countryid;

  List<Countries> r1 = [];
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];

  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    r1.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<DataProvider>(context, listen: false);
      r1 = (provider.countriesModel!.countries)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final mob = Responsive.isMobile(context);
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
                      child: SvgPicture.asset(ImageAssets.homeIconSvg)),
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(ImageAssets.chatIconSvg)),
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
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPickerSelected = false;
                  });
                },
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (ctx) {
                                      return const HomePage();
                                    }));
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_rounded,
                                    size: 30,
                                    color: ColorManager.primary,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: ProfileImage(
                                    isNavigationActive: false,
                                    iconSize: 12,
                                    profileSize: 40.5,
                                    iconRadius: 12,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: TitleWidget(name: str.e_name),
                            ),
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
                                child: TextField(
                                  focusNode: nfocus,
                                  style: const TextStyle(),
                                  controller:
                                      EditProfileControllers.nameController,
                                  decoration: InputDecoration(
                                      hintText: str.e_name_h,
                                      hintStyle: getRegularStyle(
                                          color: const Color.fromARGB(
                                              255, 173, 173, 173),
                                          fontSize: Responsive.isMobile(context)
                                              ? 15
                                              : 10)),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: TitleWidget(name: str.e_dob),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: size.width * 0.5,
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
                                          readOnly: true,
                                          controller: EditProfileControllers
                                              .dateController,
                                          decoration: InputDecoration(
                                              suffixIcon: InkWell(
                                                onTap: () =>
                                                    _selectDate(context),
                                                child: const Icon(
                                                  Icons.calendar_month,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                              hintText: str.e_dob_h,
                                              hintStyle: getRegularStyle(
                                                  color: const Color.fromARGB(
                                                      255, 173, 173, 173),
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 14
                                                      : 10)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: TitleWidget(name: str.e_gender),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                value = true;
                                              });
                                            },
                                            child: CustomizedRadioButton(
                                              gender: "MALE",
                                              isMaleSelected: value,
                                            ),
                                          ),
                                          TitleWidget(name: str.e_male),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                value = false;
                                              });
                                            },
                                            child: CustomizedRadioButton(
                                              gender: "FEMALE",
                                              isMaleSelected: value,
                                            ),
                                          ),
                                          TitleWidget(name: str.e_female),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: TitleWidget(name: str.e_country),
                            ),
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
                                child: TextField(
                                  // onTap: () {
                                  //   setState(() {
                                  //     isPickerSelected = true;
                                  //   });
                                  // },
                                  onChanged: (value) async {
                                    setState(() {
                                      isPickerSelected = true;
                                    });
                                    String capitalize(String s) =>
                                        s[0].toUpperCase() + s.substring(1);

                                    if (value.isEmpty) {
                                      r1 = [];
                                      setState(() {
                                        r1 = (provider
                                            .countriesModel!.countries)!;
                                      });
                                    } else {
                                      final lower = capitalize(value);

                                      onSearchChanged(lower);
                                    }

                                    // print(r);
                                  },
                                  style: const TextStyle(),
                                  controller: countryController,
                                  decoration: InputDecoration(
                                      hintText: str.e_country_h,
                                      hintStyle: getRegularStyle(
                                          color: const Color.fromARGB(
                                              255, 173, 173, 173),
                                          fontSize: Responsive.isMobile(context)
                                              ? 15
                                              : 10)),
                                ),
                              ),
                            ),
                            // * Region
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: TitleWidget(name: str.e_region),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: size.width * .45,
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
                                          controller: regionController,
                                          decoration: InputDecoration(
                                              hintText: str.e_region_h,
                                              hintStyle: getRegularStyle(
                                                  color: const Color.fromARGB(
                                                      255, 173, 173, 173),
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 15
                                                      : 10)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: TitleWidget(name: str.e_state),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
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
                                          controller: stateController,
                                          decoration: InputDecoration(
                                              hintText: str.e_state_h,
                                              hintStyle: getRegularStyle(
                                                  color: const Color.fromARGB(
                                                      255, 173, 173, 173),
                                                  fontSize: Responsive.isMobile(
                                                          context)
                                                      ? 15
                                                      : 10)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: TitleWidget(name: str.e_about),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Colors.grey.shade300,
                                      offset: const Offset(4, 4.5),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  child: TextField(
                                    minLines: 4,
                                    maxLines: 5,
                                    style: const TextStyle(),
                                    controller: aboutController,
                                    decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            hintText: str.e_about_h,
                                            hintStyle: getRegularStyle(
                                                color: const Color.fromARGB(
                                                    255, 173, 173, 173),
                                                fontSize:
                                                    Responsive.isMobile(context)
                                                        ? 15
                                                        : 10))
                                        .copyWith(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color:
                                                        ColorManager.whiteColor,
                                                    width: .5)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: ColorManager.whiteColor, width: .5))),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 7, 5),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 35,
                                            vertical: mob ? 16 : 10),
                                      ),
                                      onPressed: updateProfile,
                                      child: Center(
                                        child: Text(
                                          str.e_save,
                                          textAlign: TextAlign.justify,
                                          style: getRegularStyle(
                                              color: ColorManager.whiteText,
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 15
                                                      : 10),
                                        ),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      isPickerSelected
                          ? Positioned(
                              bottom:
                                  mob ? size.height * .25 : size.height * .185,
                              // top: size.height * .458,
                              right: lang == 'ar' ? size.width * .05 : null,
                              left: lang != 'ar' ? size.width * .05 : null,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Colors.grey.shade300,
                                      offset: const Offset(3, 8.5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: ColorManager.primary2,
                                    ),
                                    height: 110,
                                    width: 200,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: SizedBox(
                                          //     height: 40,
                                          //     child: TextField(
                                          //     ),
                                          //   ),
                                          // ),

                                          // Expanded(child: StreamBuilder<List<Countries>>(
                                          //   stream: ,
                                          // ))
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount:
                                                    // r.isEmpty
                                                    //     ? provider.countriesModel!.countries!.length
                                                    //     :
                                                    r1.length,
                                                shrinkWrap: true,
                                                itemBuilder: (ctx, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        countryid = r1[index]
                                                            .countryId
                                                            .toString();
                                                        r1 = (provider
                                                            .countriesModel!
                                                            .countries)!;
                                                        isPickerSelected =
                                                            false;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 35,
                                                      color:
                                                          ColorManager.primary2,
                                                      // child: r.isEmpty
                                                      //     ? Text(provider.countriesModel!.countries![index]
                                                      //             .countryName ??
                                                      //         '')
                                                      // :
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 0, 5, 0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "+${r1[index].phonecode.toString()}",
                                                                style: getSemiBoldtStyle(
                                                                    color: ColorManager
                                                                        .background,
                                                                    fontSize:
                                                                        13)),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                                r1[index]
                                                                        .countryName ??
                                                                    '',
                                                                style: getSemiBoldtStyle(
                                                                    color: ColorManager.background,
                                                                    fontSize: r1[index].countryName!.length < 12
                                                                        ? 12
                                                                        : r1[index].countryName!.length < 20
                                                                            ? 10
                                                                            : r1[index].countryName!.length > 25
                                                                                ? 8
                                                                                : 10)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // * Date selection

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme:
                    const ColorScheme.light(primary: ColorManager.primary)),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        EditProfileControllers.dateController.text =
            selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  // * Update profile

  updateProfile() {
    final name = EditProfileControllers.nameController.text.trim();
    final date = EditProfileControllers.dateController.text;
    if (name.isEmpty) {
      showAnimatedSnackBar(context, "Name field can not be empty");
    } else if (date.isEmpty) {
      showAnimatedSnackBar(context, "DOB field can not be empty");
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return const HomePage();
      }));
    }
  }

  onSearchChanged(String query) {
    setState(() {
      r1 = [];
    });
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(microseconds: 200), () {
      s(query);
    });
  }

  s(filter) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    provider.countriesModel?.countries?.forEach((element) {
      final m = element.countryName?.contains(filter);

      if (m == true) {
        setState(() {
          // r = [];
          r1.add(element);
        });
      }

      final phoneCode = element.phonecode?.toString().contains(filter);

      if (phoneCode == true) {
        setState(() {
          // r = [];
          r1.add(element);
        });
      }
    });
  }
}
