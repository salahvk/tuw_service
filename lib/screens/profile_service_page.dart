import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/screens/choose_service_page.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/customRadioButton.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/custom_stepper.dart';
import 'package:social_media_services/widgets/custom_text_field.dart';
import 'package:social_media_services/widgets/mandatory_widget.dart';
import 'package:social_media_services/widgets/title_widget.dart';

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
  int _selectedIndex = 2;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
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
                  leading: Image.asset(ImageAssets.homeIcon),
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: Image.asset(ImageAssets.chatIcon),
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
                            const MandatoryHeader(heading: 'First Name'),
                            const CustomTextField(hintText: 'Enter First Name'),
                            const MandatoryHeader(heading: 'Last Name'),
                            const CustomTextField(hintText: 'Enter Last Name'),
                            const MandatoryHeader(heading: 'Civil Card No'),
                            const CustomTextField(hintText: 'Enter Card No'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const MandatoryHeader(
                                        heading: 'Date of Birth'),
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
                                          controller: payDateController,
                                          decoration: InputDecoration(
                                              suffixIcon: InkWell(
                                                onTap: () =>
                                                    _selectDate(context),
                                                child: const Icon(
                                                  Icons.calendar_month,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                              hintText: 'Enter Date of Birth',
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
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: MandatoryHeader(heading: 'Gender'),
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
                                          const TitleWidget(name: 'Male'),
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
                                          const TitleWidget(name: 'Female'),
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
                                children: const [
                                  TitleWidget(name: 'Country'),
                                  Icon(
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
                                        hint: Text('Enter Country',
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
                                        // buttonWidth: 140,
                                        itemHeight: 40,
                                        buttonPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 0, 8, 0),
                                        // dropdownWidth: size.width,
                                        itemPadding: const EdgeInsets.fromLTRB(
                                            12, 0, 12, 0),
                                      ),
                                    ),
                                  ),
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
                                    const MandatoryHeader(heading: 'Region'),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 15, 0),
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
                                          controller: regionController,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Region',
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
                                    const MandatoryHeader(heading: 'State'),
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
                                              hintText: 'Enter State',
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
                            const MandatoryHeader(heading: 'Address'),
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
                                    controller: aboutController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        hintText: 'Enter Address',
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
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (ctx) {
                                        return const ChooseServicePage();
                                      }));
                                    },
                                    child: Text("CONTINUE",
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
        dateController.text = selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }
}
