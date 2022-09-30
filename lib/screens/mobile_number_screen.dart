import 'dart:async';
import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/controllers.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/main.dart';
import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/otp_provider.dart';
import 'package:social_media_services/screens/OTP_screen.dart';
import 'package:social_media_services/utils/snack_bar.dart';
import 'package:social_media_services/widgets/introduction_logo.dart';
import 'package:social_media_services/widgets/terms_and_condition.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  Countries? selectedValue;
  String? countryCode;
  String lang = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryCode = "91";
    print(countryCode);
    print("first");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setTimer();
    });
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
          // ElevatedButton(
          //     onPressed: () {
          //       const sm = 'India';
          //       s(sm);
          //     },
          //     child: const Text('data'))
          // DropdownSearch<List<Countries>>(
          //     // asyncItems: (filter) => getData(filter),

          //     // compareFn: (i, s) => i.isEqual(s),

          //     items: [
          //       provider.countriesModel!.countries!,
          //     ],
          //     popupProps: PopupPropsMultiSelection.menu(
          //       // isFilterOnline: true,
          //       // showSelectedItems: true,
          //       showSearchBox: true,
          //       selectionWidget: (context, item, isSelected) {
          //         return Container(
          //           color: ColorManager.errorRed,
          //           height: 5,
          //           width: 6,
          //         );
          //       },

          //       itemBuilder: customPopupItemBuilderExample2,
          //       favoriteItemProps: const FavoriteItemProps(
          //         showFavoriteItems: true,
          //         // favoriteItems: (us) {
          //         //   return us
          //         //       .where((e) => e.countryName!.contains("Mrs"))
          //         //       .toList();
          //         // },
          //       ),

          //       // validationWidgetBuilder: (ctx, selectedItems) {
          //       //   return Container(
          //       //     color: Colors.blue[200],
          //       //     height: 56,
          //       //     child: Align(
          //       //       alignment: Alignment.center,
          //       //       child: MaterialButton(
          //       //         child: const Text('OK'),
          //       //         onPressed: () {
          //       //           // _popupCustomValidationKey.currentState?.popupOnValidate();
          //       //         },
          //       //       ),
          //       //     ),
          //       //   );
          //       // },
          //     )),

          SizedBox(
            height: size.height * 0.36,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: IntroductionLogo(),
              ),
            ),
          ),

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
                          width: size.width * .18,
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
                                            //     child: ScalableImageWidget
                                            //         .fromSISource(
                                            //             scale: 5,
                                            //             onLoading: (p0) {
                                            //               return Container(
                                            //                 child:
                                            //                     const CircularProgressIndicator(
                                            //                   strokeWidth: 2,
                                            //                 ),
                                            //               );
                                            //             },
                                            //             cache:
                                            //                 ScalableImageCache(
                                            //                     size: 210),
                                            //             si: ScalableImageSource
                                            //                 .fromSvgHttpUrl(
                                            //                     // bigFloats: true,
                                            //                     Uri.parse(
                                            //                         '$endPoint${item.countryflag}')))),
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
                                          EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      child: Text('+91'),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 20),
                                      child: Text(
                                          "+${selectedValue?.phonecode.toString()}"),
                                    ),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {});
                                selectedValue = value as Countries;
                                countryCode =
                                    selectedValue?.phonecode.toString();
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

                              buttonPadding:
                                  const EdgeInsets.fromLTRB(0, 0, 6, 0),

                              itemPadding:
                                  const EdgeInsets.fromLTRB(6, 0, 0, 8),
                              isExpanded: true,
                              searchController: null,

                              // searchMatchFn: (item, searchValue) {
                              //   return (item.value.toString().contains(''));
                              //   // final s = provider.countriesModel!.countries!
                              //   //     .map((e) => e.countryName);
                              //   // return s.contains(searchValue);
                              // },

                              // searchInnerWidget: Padding(
                              //   padding: const EdgeInsets.only(
                              //     top: 8,
                              //     bottom: 4,
                              //     right: 8,
                              //     left: 8,
                              //   ),
                              //   child: TextFormField(
                              //     controller: searchCon,
                              //     onChanged: (value) {
                              //       s(value);
                              //     },
                              //     decoration: InputDecoration(
                              //       isDense: true,
                              //       contentPadding: const EdgeInsets.symmetric(
                              //         horizontal: 10,
                              //         vertical: 8,
                              //       ),
                              //       hintText: 'Search your country',
                              //       hintStyle: const TextStyle(fontSize: 12),
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(8),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              // //This to clear the search value when you close the menu
                              // onMenuStateChange: (isOpen) {
                              //   if (!isOpen) {
                              //     searchCon.clear();
                              //   }
                              // },
                            ),
                          ),
                        ),
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
                          controller: phoneNumCon,
                          style: const TextStyle(),
                          maxLength: 10,
                          decoration: InputDecoration(
                                  counterText: '',
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
                  onPressed: onContinue,
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

  onContinue() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final OtpProvider = Provider.of<OTPProvider>(context, listen: false);
    final str = AppLocalizations.of(context)!;
    final phoneNumber = phoneNumCon.text.trim();
    if (phoneNumber.isEmpty) {
      AnimatedSnackBar.material(str.m_snack,
              type: AnimatedSnackBarType.error,
              borderRadius: BorderRadius.circular(6),
              duration: const Duration(seconds: 1))
          .show(
        context,
      );
    } else if (phoneNumber.length > 10) {
      AnimatedSnackBar.material('Mobile Number must not be above 10 digits',
              type: AnimatedSnackBarType.error,
              borderRadius: BorderRadius.circular(6),
              duration: const Duration(seconds: 1))
          .show(
        context,
      );
    } else if (phoneNumber != '8089852417') {
      AnimatedSnackBar.material('Enter a valid Number',
              type: AnimatedSnackBarType.error,
              borderRadius: BorderRadius.circular(6),
              duration: const Duration(seconds: 1))
          .show(
        context,
      );
    } else {
      OtpProvider.getPhoneNo(phoneNumCon.text);
      OtpProvider.getCountryCode(countryCode);
      getOtp();
    }
  }

  getOtp() async {
    print("getting otp");
    final String id = Hive.box("LocalLan").get('lang_id');
    print(id);
    try {
      final provider = Provider.of<DataProvider>(context, listen: false);
      var response = await http.post(
          Uri.parse(
              "$apiUser/request_otp?countrycode=$countryCode&phone=${phoneNumCon.text}&language_id=$id"),
          headers: {"device-id": provider.deviceId ?? ''});
      // print(response.body);
      if (response.statusCode != 200) {
        showSnackBar("Something Went Wrong", context);
        return;
      }

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return const OTPscreen();
      }));
    } on Exception catch (e) {
      showSnackBar("Something Went Wrong", context);
      print(e);
    }
  }

// * Flutter internationalizing functions

  setTimer() {
    Future.delayed(const Duration(seconds: 1));
    getlocalLanguage();
  }

  getlocalLanguage() {
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    if (!mounted) return;
    MyApp.of(context).setLocale(
      Locale.fromSubtags(
        languageCode: lang,
      ),
    );
  }

  s(filter) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    provider.countriesModel?.countries?.forEach((element) {
      final m = element.countryName?.contains(filter);
      if (m == true) {
        print(element.countryName);
      }
      // final z = (m == true ? element.countryName : null);
      // print(z);
    });
  }
}
