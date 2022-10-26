import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/becomeServiceMan/customerParent.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/widgets/customRadioButton.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/custom_stepper.dart';
import 'package:social_media_services/widgets/custom_text_field.dart';
import 'package:social_media_services/widgets/mandatory_widget.dart';
import 'package:social_media_services/widgets/title_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileServicePage extends StatefulWidget {
  const ProfileServicePage({Key? key}) : super(key: key);

  @override
  State<ProfileServicePage> createState() => _ProfileServicePageState();
}

class _ProfileServicePageState extends State<ProfileServicePage> {
  String? selectedValue;
  bool isTickSelected = false;
  DateTime selectedDate = DateTime.now();
  bool value = true;
  final int _selectedIndex = 2;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];
  String lang = '';
  List<String> r3 = [];
  FocusNode nfocus = FocusNode();

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.requestFocus(nfocus);
    lang = Hive.box('LocalLan').get(
      'lang',
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // print(timeStamp);
      final provider = Provider.of<DataProvider>(context, listen: false);
      int? n = provider.countriesModel?.countries?.length;
      int i = 0;
      while (i < n!.toInt()) {
        r3.add(provider.countriesModel!.countries![i].countryName!);
        i++;
        print(timeStamp);
      }

      setState(() {});
      getCustomerParent(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final mob = Responsive.isMobile(context);

    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawer: SizedBox(
        height: h * 0.825,
        width: w * 0.6,
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
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.homePage, (route) => false);
                // setState(() {
                //   _selectedIndex = index;
                // });
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
              child: Column(
                children: [
                  const CustomStepper(num: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MandatoryHeader(heading: str.p_first_name),
                            CustomTextField(
                                hintText: str.p_first_name_h,
                                controller: ProfileServiceControllers
                                    .firstNameController),
                            MandatoryHeader(heading: str.p_last_name),
                            CustomTextField(
                                hintText: str.p_last_name_h,
                                controller: ProfileServiceControllers
                                    .lastNameController),
                            MandatoryHeader(heading: str.p_civil),
                            CustomTextField(
                                hintText: str.p_civil_h,
                                controller: ProfileServiceControllers
                                    .civilCardController,
                                type: TextInputType.number),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MandatoryHeader(heading: str.p_dob),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: mob ? w * 0.5 : w * .45,
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
                                          controller: ProfileServiceControllers
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
                                              hintText: str.p_dob_h,
                                              hintStyle: getRegularStyle(
                                                  color: const Color.fromARGB(
                                                      255, 173, 173, 173),
                                                  fontSize: 14)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: MandatoryHeader(
                                          heading: str.p_gender),
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
                                          TitleWidget(name: str.p_male),
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
                                          TitleWidget(name: str.p_female),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Row(
                                children: [
                                  TitleWidget(name: str.p_country),
                                  const Icon(
                                    Icons.star_outlined,
                                    size: 10,
                                    color: ColorManager.errorRed,
                                  )
                                ],
                              ),
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
                                child: Container(
                                  width: w,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: ColorManager.whiteColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                          isExpanded: true,
                                          focusNode: nfocus,
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
                                          items: r3
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(item,
                                                        style: getRegularStyle(
                                                            color: ColorManager
                                                                .black,
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
                                          dropdownMaxHeight: h * .6,
                                          // buttonWidth: 140,
                                          itemHeight: 40,
                                          buttonPadding:
                                              const EdgeInsets.fromLTRB(
                                                  12, 0, 8, 0),
                                          // dropdownWidth: size.width,
                                          itemPadding:
                                              const EdgeInsets.fromLTRB(
                                                  12, 0, 12, 0),
                                          searchController:
                                              AddressEditControllers
                                                  .searchController,
                                          searchInnerWidget: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 4,
                                              right: 8,
                                              left: 8,
                                            ),
                                            child: TextFormField(
                                              controller: AddressEditControllers
                                                  .searchController,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                // TODO: localisation
                                                hintText: 'Search a country',
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                          searchMatchFn: (item, searchValue) {
                                            return (item.value
                                                .toString()
                                                .toLowerCase()
                                                .contains(searchValue));
                                          },
                                          //This to clear the search value when you close the menu
                                          onMenuStateChange: (isOpen) {
                                            if (!isOpen) {
                                              AddressEditControllers
                                                  .searchController
                                                  .clear();
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       boxShadow: [
                            //         BoxShadow(
                            //           blurRadius: 10.0,
                            //           color: Colors.grey.shade300,
                            //           // offset: const Offset(5, 8.5),
                            //         ),
                            //       ],
                            //     ),
                            //     child: Container(
                            //       width: w,
                            //       height: 50,
                            //       decoration: BoxDecoration(
                            //           color: ColorManager.whiteColor,
                            //           borderRadius: BorderRadius.circular(8)),
                            //       child: Padding(
                            //         padding:
                            //             const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            //         child: DropdownButtonHideUnderline(
                            //           child: DropdownButton2(
                            //             icon: const Icon(
                            //               Icons.keyboard_arrow_down,
                            //               size: 35,
                            //               color: ColorManager.black,
                            //             ),
                            //             hint: Text(str.p_country_h,
                            //                 style: getRegularStyle(
                            //                     color: const Color.fromARGB(
                            //                         255, 173, 173, 173),
                            //                     fontSize: 15)),
                            //             items: items
                            //                 .map((item) =>
                            //                     DropdownMenuItem<String>(
                            //                       value: item,
                            //                       child: Text(item,
                            //                           style: getRegularStyle(
                            //                               color: ColorManager
                            //                                   .black,
                            //                               fontSize: 15)),
                            //                     ))
                            //                 .toList(),
                            //             value: selectedValue,
                            //             onChanged: (value) {
                            //               setState(() {
                            //                 selectedValue = value as String;
                            //               });
                            //             },
                            //             buttonHeight: 40,
                            //             // buttonWidth: 140,
                            //             itemHeight: 40,
                            //             buttonPadding:
                            //                 const EdgeInsets.fromLTRB(
                            //                     12, 0, 8, 0),
                            //             // dropdownWidth: size.width,
                            //             itemPadding: const EdgeInsets.fromLTRB(
                            //                 12, 0, 12, 0),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            // * Region
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MandatoryHeader(heading: str.p_region),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: w * .44,
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
                                          controller: ProfileServiceControllers
                                              .regionController,
                                          decoration: InputDecoration(
                                              hintText: str.p_region_h,
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
                                    MandatoryHeader(heading: str.p_state),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: w * .44,
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
                                          controller: ProfileServiceControllers
                                              .stateController,
                                          decoration: InputDecoration(
                                              hintText: str.p_state_h,
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
                            MandatoryHeader(heading: str.p_address),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
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
                                    controller: ProfileServiceControllers
                                        .addressController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        hintText: str.p_address_h,
                                        hintStyle: getRegularStyle(
                                            color: const Color.fromARGB(
                                                255, 173, 173, 173),
                                            fontSize: 15)),
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(
                                            28, 0, 28, 0)),
                                    onPressed: onContinue,
                                    child: Text(str.p_continue,
                                        style: getRegularStyle(
                                            color: ColorManager.whiteText,
                                            fontSize: 16))),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

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
        ProfileServiceControllers.dateController.text =
            selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  onContinue() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (ProfileServiceControllers.firstNameController.text.isEmpty) {
      showAnimatedSnackBar(context, "Please Enter Your First Name");
    }
    //  else if (ProfileServiceControllers.lastNameController.text.isEmpty) {
    //   showAnimatedSnackBar(context, "Please Enter Your Last Name");
    // } else if (ProfileServiceControllers.civilCardController.text.isEmpty) {
    //   showAnimatedSnackBar(context, "Please Enter Your Civil Card Number");
    // } else if (ProfileServiceControllers.dateController.text.isEmpty) {
    //   showAnimatedSnackBar(context, "Please Enter Your Date of birth");
    // } else if (ProfileServiceControllers.regionController.text.isEmpty) {
    //   showAnimatedSnackBar(context, "Please Enter Your Region");
    // } else if (ProfileServiceControllers.stateController.text.isEmpty) {
    //   showAnimatedSnackBar(context, "Please Enter Your State");
    // } else if (ProfileServiceControllers.addressController.text.isEmpty) {
    //   showAnimatedSnackBar(context, "Please Enter Your Address");
    // }
    else {
      Navigator.pushNamed(context, Routes.chooseService);
    }
  }
}
