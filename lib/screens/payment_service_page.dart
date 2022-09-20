import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/payment_successfull_page.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/custom_stepper.dart';
import 'package:social_media_services/widgets/mandatory_widget.dart';
import 'package:social_media_services/widgets/monthly_plan.dart';

class PaymentServicePage extends StatefulWidget {
  const PaymentServicePage({Key? key}) : super(key: key);

  @override
  State<PaymentServicePage> createState() => _PaymentServicePageState();
}

class _PaymentServicePageState extends State<PaymentServicePage> {
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
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      ImageAssets.homeIcon,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: SizedBox(
                      width: 24,
                      height: 24,
                      child:
                          Image.asset(ImageAssets.chatIcon, fit: BoxFit.cover)),
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
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomStepper(num: 3),
                      const MandatoryHeader(heading: 'Card Holder Name'),
                      const TextFieldProfileService(
                          hintText: 'Enter Holder Name'),
                      const MandatoryHeader(heading: 'Card Number'),
                      const TextFieldProfileService(hintText: 'Enter Card No'),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MandatoryHeader(heading: 'Expired Date'),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  width: size.width * 0.45,
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
                                          onTap: () => _selectDate(context),
                                          child: const Icon(
                                            Icons.calendar_month,
                                            color: ColorManager.primary,
                                          ),
                                        ),
                                        hintText: 'Expired Date',
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
                                child: MandatoryHeader(heading: 'CVV Code'),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: size.width * .45,
                                        child: const TextFieldProfileService(
                                            hintText: 'Enter CVV')),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),

                      const MandatoryHeader(heading: 'Coupon Code'),
                      const TextFieldProfileService(
                          hintText: 'Enter Coupon Code'),

                      // * Region
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MonthlyPlan(
                                  size: size,
                                  plan: "Monthly Plan",
                                  amount: '\$135.00',
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MonthlyPlan(
                                    size: size,
                                    plan: "Yearly Plan",
                                    amount: '\$207.00')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 25),
                        child: Container(
                          width: size.width,
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
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("MONTHLY PLAN",
                                      style: getBoldtStyle(
                                          color: ColorManager.black,
                                          fontSize: 18)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("Service Fee : \$135.00 OMR",
                                      style: getRegularStyle(
                                          color: const Color.fromARGB(
                                              255, 173, 173, 173),
                                          fontSize: 16)),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text(
                                        "Discount      : \$7.00 OMR = 5%",
                                        style: getRegularStyle(
                                            color: const Color.fromARGB(
                                                255, 173, 173, 173),
                                            fontSize: 16)),
                                  ),
                                  Text("VAT               : \$12.00 OMR = 8%",
                                      style: getRegularStyle(
                                          color: const Color.fromARGB(
                                              255, 173, 173, 173),
                                          fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 0, 28, 0)),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (ctx) {
                                  return const PaymentSuccessPage();
                                }), (route) => false);
                              },
                              child: Text("PAY NOW",
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

class TextFieldProfileService extends StatelessWidget {
  final String hintText;
  const TextFieldProfileService({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          // focusNode: nfocus,
          style: const TextStyle(),
          // controller: nameController,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: getRegularStyle(
                  color: const Color.fromARGB(255, 173, 173, 173),
                  fontSize: 15)),
        ),
      ),
    );
  }
}
