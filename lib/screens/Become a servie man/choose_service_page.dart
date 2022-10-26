import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/becomeServiceMan/customerParent.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/get_child_service.dart';
import 'package:social_media_services/model/get_home.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_service_page.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/custom_stepper.dart';
import 'package:social_media_services/widgets/terms_and_condition.dart';
import 'package:social_media_services/widgets/title_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseServicePage extends StatefulWidget {
  const ChooseServicePage({Key? key}) : super(key: key);

  @override
  State<ChooseServicePage> createState() => _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage> {
  Childservices? childSelectedValue;
  Services? selectedValue;
  bool isTickSelected = false;
  String? fileName;
  int _selectedIndex = 2;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];
  String lang = '';
  List<Services> sGroup = [];
  List<Childservices> childGroup = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<DataProvider>(context, listen: false);
      int? n = provider.customerParentSer?.services?.length;
      int i = 0;
      while (i < n!.toInt()) {
        sGroup.add(provider.customerParentSer!.services![i]);
        i++;
      }
      // print(sGroup[0]);

      setState(() {});
      // getCustomerChild(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<DataProvider>(context, listen: false);
    // final List<String> items = [
    //   'Item1',
    //   'Item2',
    //   'Item3',
    //   'Item4',
    // ];
    //  final List<String> items2 = provider.customerParentSer.services[0].service ?? '';
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomStepper(num: 2),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          children: [
                            TitleWidget(name: str.c_service_group),
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
                            width: size.width,
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 35,
                                    color: ColorManager.black,
                                  ),
                                  hint: Text(str.c_service_group_h,
                                      style: getRegularStyle(
                                          color: const Color.fromARGB(
                                              255, 173, 173, 173),
                                          fontSize: 15)),
                                  items: sGroup
                                      .map((item) => DropdownMenuItem<Services>(
                                            value: item,
                                            child: Text(item.service ?? '',
                                                style: getRegularStyle(
                                                    color: ColorManager.black,
                                                    fontSize: 15)),
                                          ))
                                      .toList(),
                                  // value: selectedValue,
                                  customButton: selectedValue == null
                                      ? null
                                      : Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Text(
                                              selectedValue?.service ?? ''),
                                        ),
                                  onChanged: (value) {
                                    setState(() {
                                      print(value);
                                      selectedValue = value as Services;
                                    });
                                    getChildData();
                                  },
                                  buttonHeight: 40,
                                  // buttonWidth: 140,
                                  itemHeight: 40,
                                  buttonPadding:
                                      const EdgeInsets.fromLTRB(12, 0, 8, 0),
                                  // dropdownWidth: size.width,
                                  itemPadding:
                                      const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          children: [
                            TitleWidget(name: str.c_service_list),
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
                            height: 60,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 35,
                                    color: ColorManager.black,
                                  ),
                                  hint: Text('Enter Group',
                                      style: getRegularStyle(
                                          color: const Color.fromARGB(
                                              255, 173, 173, 173),
                                          fontSize: 15)),
                                  items: childGroup
                                      .map((item) =>
                                          DropdownMenuItem<Childservices>(
                                            value: item,
                                            child: Text(item.service ?? 'null',
                                                style: getRegularStyle(
                                                    color: ColorManager.black,
                                                    fontSize: 15)),
                                          ))
                                      .toList(),
                                  // value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      childSelectedValue =
                                          value as Childservices;
                                    });
                                  },
                                  buttonHeight: 40,
                                  // buttonWidth: 140,
                                  itemHeight: 40,
                                  buttonPadding:
                                      const EdgeInsets.fromLTRB(12, 0, 8, 0),
                                  // dropdownWidth: size.width,
                                  itemPadding:
                                      const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          children: [
                            TitleWidget(name: str.c_vehicle),
                            const Icon(
                              Icons.star_outlined,
                              size: 10,
                              color: ColorManager.errorRed,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
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
                            height: 60,
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 13, 10, 13),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.fromLTRB(
                                              13, 0, 13, 0)),
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['pdf', 'doc'],
                                        );

                                        if (result != null) {
                                          PlatformFile file =
                                              result.files.first;
                                          setState(() {
                                            fileName = file.name;
                                          });
                                        } else {}
                                      },
                                      child: Text(str.c_browse,
                                          style: getLightStyle(
                                              color: ColorManager.whiteText,
                                              fontSize: 18))),
                                ),
                                Text(fileName ?? '')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                isTickSelected = !isTickSelected;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 15, 10, 17),
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: ColorManager.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Colors.grey.shade300,
                                      // offset: const Offset(5, 8.5),
                                    ),
                                  ],
                                ),
                                child: isTickSelected
                                    ? Image.asset('assets/tick_mark.png')
                                    : null,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: TermsAndCondition(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(13, 0, 13, 0)),
                              onPressed: continueToPay,
                              child: Text(str.c_pay,
                                  style: getRegularStyle(
                                      color: ColorManager.whiteText,
                                      fontSize: 16))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  continueToPay() {
    final str = AppLocalizations.of(context)!;
    isTickSelected
        ? Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return const PaymentServicePage();
          }))
        : AnimatedSnackBar.material(str.c_snack,
                type: AnimatedSnackBarType.warning,
                borderRadius: BorderRadius.circular(6),
                // brightness: Brightness.dark,
                duration: const Duration(seconds: 1))
            .show(
            context,
          );
  }

  getChildData() async {
    await getCustomerChild(context, selectedValue?.id);
    getDropDownData();
  }

  getDropDownData() {
    final provider = Provider.of<DataProvider>(context, listen: false);
    int? n = provider.customerChildSer?.childservices?.length;
    int i = 0;
    while (i < n!.toInt()) {
      childGroup.add(provider.customerChildSer!.childservices![i]);
      i++;
    }
    // print(sGroup[0]);

    setState(() {});
  }
}

 //   if (isTickSelected) {
    //   if (ChooseServiceControllers.serviceGroupController.text.isEmpty) {
    //   showAnimatedSnackBar(context, "Please Enter Service");
    // }
    //   Navigator.push(context, MaterialPageRoute(builder: (ctx) {
    //     return const PaymentServicePage();
    //   }));
    // } else {
    //   AnimatedSnackBar.material(str.c_snack,
    //           type: AnimatedSnackBarType.warning,
    //           borderRadius: BorderRadius.circular(6),
    //           // brightness: Brightness.dark,
    //           duration: const Duration(seconds: 1))
    //       .show(
    //     context,
    //   );
    // }

