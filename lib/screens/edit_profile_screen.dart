import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/customRadioButton.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/profile_image.dart';
import 'package:social_media_services/widgets/title_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<EditProfileScreen> {
  DateTime selectedDate = DateTime.now();
  // String? gender;
  bool value = true;
  // bool female = false;
  FocusNode nfocus = FocusNode();
  FocusNode dobfocus = FocusNode();
  int _selectedIndex = 2;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];

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
              tabs: [
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: Image.asset(
                    ImageAssets.homeIcon,
                    fit: BoxFit.cover,
                  ),
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: Image.asset(ImageAssets.chatIcon, fit: BoxFit.cover),
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
              child: SingleChildScrollView(
                child: Padding(
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ProfileImage(
                              isNavigationActive: false,
                              iconSize: 12,
                              profileSize: 40.5,
                              iconRadius: 12,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TitleWidget(name: 'Name'),
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
                            controller: nameController,
                            decoration: InputDecoration(
                                hintText: 'Enter Name',
                                hintStyle: getRegularStyle(
                                    color: const Color.fromARGB(
                                        255, 173, 173, 173),
                                    fontSize: 15)),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: TitleWidget(name: 'Date of Birth'),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                    controller: dateController,
                                    decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                          onTap: () => _selectDate(context),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: TitleWidget(name: 'Gender'),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: TitleWidget(name: 'Country'),
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
                            style: const TextStyle(),
                            controller: countryController,
                            decoration: InputDecoration(
                                hintText: 'Enter Country',
                                hintStyle: getRegularStyle(
                                    color: const Color.fromARGB(
                                        255, 173, 173, 173),
                                    fontSize: 15)),
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
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: TitleWidget(name: 'Region'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 15, 0),
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
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: TitleWidget(name: 'State'),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: TitleWidget(name: 'About'),
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
                                      hintText: 'Enter About',
                                      hintStyle: getRegularStyle(
                                          color: const Color.fromARGB(
                                              255, 173, 173, 173),
                                          fontSize: 15))
                                  .copyWith(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: ColorManager.whiteColor,
                                              width: .5)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: ColorManager.whiteColor,
                                              width: .5))),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       padding: const EdgeInsets.symmetric(
                          //           horizontal: 20, vertical: 5),
                          //     ),
                          //     onPressed: () {},
                          //     child: const Text(
                          //       'CHANGE \nMOBILE NO',
                          //       textAlign: TextAlign.center,
                          //     )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 7, 5),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 16),
                                ),
                                onPressed: () {
                                  // print(nameController.text);
                                  // nameController.clear();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (ctx) {
                                    return const HomePage();
                                  }));
                                },
                                child: Center(
                                  child: Text(
                                    'SAVE',
                                    textAlign: TextAlign.justify,
                                    style: getRegularStyle(
                                        color: ColorManager.whiteText,
                                        fontSize: 15),
                                  ),
                                )),
                          )
                        ],
                      )
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
        dateController.text = selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }
}
