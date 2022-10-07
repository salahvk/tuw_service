import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
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
import 'package:social_media_services/utils/snack_bar.dart';
import 'package:social_media_services/utils/viewProfile.dart';
import 'package:social_media_services/widgets/animatedSnackBar.dart';
import 'package:social_media_services/widgets/customRadioButton.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/profile_image.dart';
import 'package:social_media_services/widgets/title_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

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
  int? countryid;
  String gender = 'male';

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
      viewProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.height);
    final h = MediaQuery.of(context).size.height;
    final str = AppLocalizations.of(context)!;
    final mob = Responsive.isMobile(context);
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
            height: h * .085,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Colors.grey.shade400,
                offset: const Offset(6, 1),
              ),
            ]),
          ),
          SizedBox(
            height: h * .082,
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
          : GestureDetector(
              // onTap: () {
              //   setState(() {
              //     isPickerSelected = false;
              //   });
              // },
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, h * .05, 15, 0),
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: ProfileImage(
                                  // image: provider.viewProfileModel
                                  //         ?.userdetails?.profilePic ??
                                  //     '',
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: TitleWidget(name: str.e_dob),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Container(
                                      width: mob
                                          ? size.width * 0.5
                                          : size.width * .45,
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
                                              onTap: () => _selectDate(context),
                                              child: const Icon(
                                                Icons.calendar_month,
                                                color: ColorManager.primary,
                                              ),
                                            ),
                                            hintText: str.e_dob_h,
                                            hintStyle: getRegularStyle(
                                                color: const Color.fromARGB(
                                                    255, 173, 173, 173),
                                                fontSize:
                                                    Responsive.isMobile(context)
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
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: TitleWidget(name: str.e_gender),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              value = true;
                                              gender = 'male';
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
                                              gender = 'female';
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
                                      r1 =
                                          (provider.countriesModel!.countries)!;
                                    });
                                  } else {
                                    final lower = capitalize(value);

                                    onSearchChanged(lower);
                                  }

                                  // print(r);
                                },
                                style: const TextStyle(),
                                controller:
                                    EditProfileControllers.countryController,
                                decoration: InputDecoration(
                                    hintText: str.e_country_h,
                                    hintStyle: getRegularStyle(
                                        color: const Color.fromARGB(
                                            255, 173, 173, 173),
                                        fontSize: mob ? 15 : 10)),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: TitleWidget(name: str.e_state),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                        controller: EditProfileControllers
                                            .stateController,
                                        decoration: InputDecoration(
                                            hintText: str.e_state_h,
                                            hintStyle: getRegularStyle(
                                                color: const Color.fromARGB(
                                                    255, 173, 173, 173),
                                                fontSize:
                                                    Responsive.isMobile(context)
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: TitleWidget(name: str.e_region),
                                  ),
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
                                        controller: EditProfileControllers
                                            .regionController,
                                        decoration: InputDecoration(
                                            hintText: str.e_region_h,
                                            hintStyle: getRegularStyle(
                                                color: const Color.fromARGB(
                                                    255, 173, 173, 173),
                                                fontSize:
                                                    Responsive.isMobile(context)
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
                                  controller:
                                      EditProfileControllers.aboutController,
                                  decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          hintText: str.e_about_h,
                                          hintStyle: getRegularStyle(
                                              color: const Color.fromARGB(
                                                  255, 173, 173, 173),
                                              fontSize: Responsive.isMobile(context)
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: ColorManager.whiteColor, width: .5))),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(7, 0, 7, 5),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 35,
                                          vertical: mob ? 16 : 10),
                                    ),
                                    onPressed: updateProfileValidation,
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
                            top: mob ? size.height * .53 : 410,
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
                                  width: 160,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            itemCount: r1.length,
                                            itemBuilder: (ctx, index) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    countryid =
                                                        r1[index].countryId;
                                                    r1 = (provider
                                                        .countriesModel!
                                                        .countries)!;
                                                    isPickerSelected = false;
                                                  });
                                                },
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      countryid =
                                                          r1[index].countryId;
                                                      EditProfileControllers
                                                          .countryController
                                                          .text = r1[index]
                                                              .countryName ??
                                                          '';
                                                      isPickerSelected = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 25,
                                                    color:
                                                        ColorManager.primary2,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 0, 5, 0),
                                                      child: Row(
                                                        children: [
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
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
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

  updateProfileValidation() {
    final name = EditProfileControllers.nameController.text.trim();
    final dob = EditProfileControllers.dateController.text;
    final country = EditProfileControllers.countryController.text;
    if (name.isEmpty) {
      showAnimatedSnackBar(context, "Name field can not be empty");
    } else if (dob.isEmpty) {
      showAnimatedSnackBar(context, "DOB field can not be empty");
    } else if (country.isEmpty) {
      showAnimatedSnackBar(context, "Country field can not be empty");
    } else {
      updateProfile(name, dob);
    }
  }

  updateProfile(name, dob) async {
    final apiToken = Hive.box("token").get('api_token');
    final provider = Provider.of<DataProvider>(context, listen: false);
    final about = EditProfileControllers.aboutController.text;
    final region = EditProfileControllers.regionController.text;
    print(countryid);
    try {
      var response = await http.post(
          Uri.parse(
              "$endPoint/api/update/userprofile?name=$name&gender=$gender&dob=$dob&about=$about&region=gfc&country_id=$countryid&state_id=12"),
          headers: {
            "device-id": provider.deviceId ?? '',
            "api-token": apiToken
          });
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        // var otpVerifiedData = OtpVerification.fromJson(jsonResponse);
        // otpProvider.getOtpVerifiedData(otpVerifiedData);
        navigateToNext();
      } else {
        print(response.statusCode);
        print(response.body);
        print('Something went wrong');
      }
    } on Exception catch (e) {
      print(e);
      showSnackBar("Something Went Wrong1", context);
    }
  }

  navigateToNext() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
      return const HomePage();
    }));
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

  // viewProfile() async {
  //   print("view profile");
  //   final apiToken = Hive.box("token").get('api_token');
  //   final provider = Provider.of<DataProvider>(context, listen: false);

  //   try {
  //     var response = await http.get(Uri.parse(viewUserProfileApi), headers: {
  //       "device-id": provider.deviceId ?? '',
  //       "api-token": apiToken
  //     });
  //     if (response.statusCode == 200) {
  //       var jsonResponse = jsonDecode(response.body);
  //       print(jsonResponse);

  //       var viewProfileData = ViewProfileModel.fromJson(jsonResponse);
  //       provider.viewProfileData(viewProfileData);
  //       print(provider.viewProfileModel!.userdetails!.profilePic ?? '');
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       print('Something went wrong');
  //     }
  //   } on Exception catch (e) {
  //     print(e);
  //     showSnackBar("Something Went Wrong1", context);
  //   }
  // }
}
