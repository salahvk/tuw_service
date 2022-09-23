import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
// import 'package:jovial_svg/jovial_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/OTP_screen.dart';
import 'package:social_media_services/widgets/introduction_logo.dart';
import 'package:social_media_services/widgets/terms_and_condition.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  Countries? selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.36,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: IntroductionLogo(),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(8),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         boxShadow: [
          //           BoxShadow(
          //             blurRadius: 10.0,
          //             color: Colors.grey.shade300,
          //             offset: const Offset(5, 8.5),
          //           ),
          //         ],
          //       ),
          //       child: Row(
          //         children: [
          //           Container(
          //             decoration: const BoxDecoration(
          //               color: ColorManager.whiteText,
          //             ),
          //             // height: 64,
          //             padding: const EdgeInsets.only(
          //                 left: 0, right: 0, top: 10, bottom: 10),
          //             // width: 100,
          //             child: Row(
          //               children: [
          //                 Padding(
          //                   padding: const EdgeInsets.only(left: 0, right: 0),
          //                   child: SizedBox(
          //                     width: 30,
          //                     child: DropdownButtonHideUnderline(
          //                       child: SizedBox(
          //                         width: 30,
          //                         child: DropdownButton2(
          //                           // icon: const Icon(
          //                           //   Icons.keyboard_arrow_down,
          //                           //   size: 35,
          //                           //   color: ColorManager.black,
          //                           // ),
          //                           hint: Text('+',
          //                               style: getRegularStyle(
          //                                   color: const Color.fromARGB(
          //                                       255, 173, 173, 173),
          //                                   fontSize: 15)),
          //                           items: provider.countriesModel?.countries
          //                               ?.map((item) =>
          //                                   DropdownMenuItem<Countries>(
          //                                     value: item,
          //                                     child: Text(
          //                                         item.countryName ?? '',
          //                                         style: getRegularStyle(
          //                                             color: ColorManager.black,
          //                                             fontSize: 15)),
          //                                   ))
          //                               .toList(),
          //                           value: selectedValue,
          //                           onChanged: (value) {
          //                             setState(() {
          //                               selectedValue = value as String;
          //                             });
          //                           },
          //                           buttonHeight: 40,
          //                           // buttonWidth: 140,
          //                           itemHeight: 40, dropdownWidth: 180,
          //                           buttonWidth: 90,
          //                           dropdownMaxHeight: 200,
          //                           buttonPadding:
          //                               const EdgeInsets.fromLTRB(12, 0, 0, 0),
          //                           // dropdownWidth: size.width,
          //                           itemPadding:
          //                               const EdgeInsets.fromLTRB(12, 0, 0, 0),
          //                         ),
          //                       ),
          //                     ),
          //                   ),

          //                   Text(
          //                     '+976',
          //                     style: getRegularStyle(
          //                         color: Colors.black54, fontSize: 17),
          //                   ),
          //                 ),
          //                 Container(
          //                   height: 40,
          //                   width: .6,
          //                   color: ColorManager.grayLight,
          //                 )
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             width: 300,
          //             height: 64,
          //             child: TextField(
          //               keyboardType: TextInputType.phone,
          //               style: const TextStyle(),
          //               decoration: InputDecoration(
          //                       contentPadding: const EdgeInsets.only(
          //                           left: 0, right: 10, top: 20, bottom: 20),
          //                       hintText: str.m_ent_mob_no,
          //                       hintStyle: getRegularStyle(
          //                           color: ColorManager.grayLight,
          //                           fontSize: 15))
          //                   .copyWith(
          //                       // enabledBorder: const OutlineInputBorder(
          //                       //     borderRadius: BorderRadius.only(
          //                       //         topRight: Radius.circular(5),
          //                       //         bottomRight: Radius.circular(5)),
          //                       //     borderSide: BorderSide(
          //                       //         color: ColorManager.whiteColor,
          //                       //         width: .5)),
          //                       // focusedBorder: const OutlineInputBorder(
          //                       //     borderRadius: BorderRadius.only(
          //                       //         topRight: Radius.circular(5),
          //                       //         bottomRight: Radius.circular(5)),
          //                       //     borderSide: BorderSide(
          //                       //         color: ColorManager.whiteColor,
          //                       //         width: .5))
          //                       ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.grey.shade300,
                    offset: const Offset(5, 8.5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorManager.whiteColor,
                  ),
                  // width: 500,
                  height: 60,

                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          width: 50,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              iconSize: 0,
                              hint: Text('',
                                  style: getRegularStyle(
                                      color: const Color.fromARGB(
                                          255, 173, 173, 173),
                                      fontSize: 15)),
                              items: provider.countriesModel?.countries
                                  ?.map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Row(
                                          children: [
                                            // SizedBox(
                                            //     width: 23,
                                            //     height: 15,
                                            //     child: ScalableImageWidget(
                                            //         si: provider.SIimage!)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 6, 0),
                                              child: Text(
                                                  '+${item.phonecode.toString()}',
                                                  style: getSemiBoldtStyle(
                                                      color: ColorManager
                                                          .background,
                                                      fontSize: 13)),
                                            ),
                                            Text(item.countryName ?? '',
                                                style: getSemiBoldtStyle(
                                                    color:
                                                        ColorManager.background,
                                                    fontSize: item.countryName!
                                                                .length <
                                                            12
                                                        ? 12
                                                        : item.countryName!
                                                                    .length <
                                                                20
                                                            ? 10
                                                            : item.countryName!
                                                                        .length >
                                                                    25
                                                                ? 6
                                                                : 8)),
                                          ],
                                        ),
                                      ))
                                  .toList(),

                              customButton: selectedValue == null
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 0, 20),
                                      child: Text('+91'),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 0, 20),
                                      child: Text(
                                          "+${selectedValue?.phonecode.toString()}"),
                                    ),
                              value: selectedValue,
                              onChanged: (value) {
                                print(value);
                                setState(() {});
                                selectedValue = value as Countries;
                                print(selectedValue?.phonecode);

                                // final s = selectedValue.toString().split(' ');
                                // print(s[2]);
                              },
                              buttonHeight: 40,
                              dropdownPadding:
                                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              // buttonWidth: 140,
                              itemHeight: 40, dropdownWidth: 200,
                              buttonWidth: 80,
                              style: getRegularStyle(
                                  color: Colors.black54, fontSize: 17),
                              dropdownMaxHeight: 200,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ColorManager.primary2,
                              ),
                              // dropdownPadding:
                              //     const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              buttonPadding:
                                  const EdgeInsets.fromLTRB(0, 0, 6, 0),
                              // dropdownWidth: size.width,
                              itemPadding:
                                  const EdgeInsets.fromLTRB(6, 0, 0, 8),
                              isExpanded: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 40,
                        width: .6,
                        color: ColorManager.grayLight,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: SizedBox(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(),
                          decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 0, right: 10, top: 20, bottom: 20),
                                  hintText: str.m_ent_mob_no,
                                  hintStyle: getRegularStyle(
                                      color: ColorManager.grayLight,
                                      fontSize: 15))
                              .copyWith(
                                  // enabledBorder: const OutlineInputBorder(
                                  //     borderRadius: BorderRadius.only(
                                  //         topRight: Radius.circular(5),
                                  //         bottomRight: Radius.circular(5)),
                                  //     borderSide: BorderSide(
                                  //         color: ColorManager.whiteColor,
                                  //         width: .5)),
                                  // focusedBorder: const OutlineInputBorder(
                                  //     borderRadius: BorderRadius.only(
                                  //         topRight: Radius.circular(5),
                                  //         bottomRight: Radius.circular(5)),
                                  //     borderSide: BorderSide(
                                  //         color: ColorManager.whiteColor,
                                  //         width: .5))
                                  ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 30),
            child: Text(str.m_sub1,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: ColorManager.grayLight, fontSize: 15)),
          ),
          Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.5,
                    color: Colors.grey.shade400,
                    offset: const Offset(6, 6),
                  ),
                ],
              ),
              width: 220,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return const OTPscreen();
                    }));
                  },
                  child: Text(
                    str.m_continue,
                    style: getRegularStyle(
                        color: ColorManager.whiteText, fontSize: 18),
                  ))),
          // const TroubleSign(),
          const Spacer(),
          const TermsAndCondition()
        ],
      )),
    );
  }
}
