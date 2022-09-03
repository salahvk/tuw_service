import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/payment_service_page.dart';
import 'package:social_media_services/widgets/custom_stepper.dart';
import 'package:social_media_services/widgets/terms_and_condition.dart';
import 'package:social_media_services/widgets/title_widget.dart';

class ChooseServicePage extends StatefulWidget {
  const ChooseServicePage({Key? key}) : super(key: key);

  @override
  State<ChooseServicePage> createState() => _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage> {
  String? selectedValue;
  bool isTickSelected = false;

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomStepper(num: 2),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  children: const [
                    TitleWidget(name: 'Service Group'),
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
                                  color:
                                      const Color.fromARGB(255, 173, 173, 173),
                                  fontSize: 15)),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item,
                                        style: getRegularStyle(
                                            color: ColorManager.black,
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
                          buttonPadding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                          // dropdownWidth: size.width,
                          itemPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  children: const [
                    TitleWidget(name: 'Service List'),
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
                                  color:
                                      const Color.fromARGB(255, 173, 173, 173),
                                  fontSize: 15)),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item,
                                        style: getRegularStyle(
                                            color: ColorManager.black,
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
                          buttonPadding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                          // dropdownWidth: size.width,
                          itemPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  children: const [
                    TitleWidget(name: 'Vehicle Registration Card/ CR Copy'),
                    Icon(
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
                          padding: const EdgeInsets.fromLTRB(10, 13, 10, 13),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(13, 0, 13, 0)),
                              onPressed: () {},
                              child: Text("Browse",
                                  style: getLightStyle(
                                      color: ColorManager.whiteText,
                                      fontSize: 18))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isTickSelected = !isTickSelected;
                      });
                    },
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: TermsAndCondition(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return const PaymentServicePage();
                        }));
                      },
                      child: Text("CONTINUE TO PAY",
                          style: getRegularStyle(
                              color: ColorManager.whiteText, fontSize: 16))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
