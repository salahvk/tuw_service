import 'dart:async';
import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/controllers.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/main.dart';
import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/model/get_otp.dart';
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
  List<Countries> r = [];
  bool isPickerSelected = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    countryCode = "91";
    lang = Hive.box('LocalLan').get(
      'lang',
    );

    r.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<DataProvider>(context, listen: false);
      r = (provider.countriesModel!.countries)!;
      setTimer();
    });
    print(r);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print(size.height);
    // print(size.width);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        setState(() {
          isPickerSelected = false;
        });
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
          // reverse: true,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.36,
                    child: Center(
                      child: Padding(
                        padding:
                            EdgeInsets.fromLTRB(0, 0, 0, size.height * .04),
                        child: const IntroductionLogo(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, size.height * .025, 20, 0),
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
                          height: size.height * .07,

                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isPickerSelected = true;
                                  });
                                },
                                child: SizedBox(
                                    width: size.width * .18,
                                    height: size.height * .07,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 3, 0),
                                        child: Text(
                                          "+${countryCode.toString()}",
                                          style: getRegularStyle(
                                              color: ColorManager
                                                  .paymentPageColor2,
                                              fontSize: 16),
                                        ),
                                      ),
                                    )),
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
                                              left: 0,
                                              right: 10,
                                              top: 0,
                                              bottom: 0),
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
                  // const Spacer(),
                  SizedBox(
                    height: size.height < 600 ? h * .13 : h * .26,
                  ),
                  const TermsAndCondition()
                ],
              ),
              isPickerSelected
                  ? Positioned(
                      // bottom: 0,
                      top: size.height * .458,
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
                            height: 200,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 40,
                                      child: TextField(
                                        onChanged: (value) async {
                                          String capitalize(String s) =>
                                              s[0].toUpperCase() +
                                              s.substring(1);

                                          if (value.isEmpty) {
                                            print('empty');
                                            r = [];
                                            setState(() {
                                              r = (provider
                                                  .countriesModel!.countries)!;
                                            });

                                            print(r.length);
                                          } else {
                                            final lower = capitalize(value);
                                            print(lower);

                                            _onSearchChanged(lower);
                                            print(r.length);
                                          }

                                          // print(r);
                                        },
                                      ),
                                    ),
                                  ),

                                  // Expanded(child: StreamBuilder<List<Countries>>(
                                  //   stream: ,
                                  // ))
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                            // r.isEmpty
                                            //     ? provider.countriesModel!.countries!.length
                                            //     :
                                            r.length,
                                        shrinkWrap: true,
                                        itemBuilder: (ctx, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                countryCode = r[index]
                                                    .phonecode
                                                    .toString();
                                                r = (provider.countriesModel!
                                                    .countries)!;
                                                isPickerSelected = false;
                                              });
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 35,
                                              color: ColorManager.primary2,
                                              // child: r.isEmpty
                                              //     ? Text(provider.countriesModel!.countries![index]
                                              //             .countryName ??
                                              //         '')
                                              // :
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 5, 0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "+${r[index].phonecode.toString()}",
                                                        style: getSemiBoldtStyle(
                                                            color: ColorManager
                                                                .background,
                                                            fontSize: 13)),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                        r[index].countryName ??
                                                            '',
                                                        style:
                                                            getSemiBoldtStyle(
                                                                color: ColorManager
                                                                    .background,
                                                                fontSize: r[index]
                                                                            .countryName!
                                                                            .length <
                                                                        12
                                                                    ? 12
                                                                    : r[index].countryName!.length <
                                                                            20
                                                                        ? 10
                                                                        : r[index].countryName!.length >
                                                                                25
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
        )),
      ),
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
    }
    // else if (phoneNumber != '8089852417') {
    //   AnimatedSnackBar.material('Enter a valid Number',
    //           type: AnimatedSnackBarType.error,
    //           borderRadius: BorderRadius.circular(6),
    //           duration: const Duration(seconds: 1))
    //       .show(
    //     context,
    //   );
    // }
    else {
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
      final otpProvider = Provider.of<OTPProvider>(context, listen: false);
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
      var getOtpData = GetOtp.fromJson(jsonResponse);
      otpProvider.getOtpData(getOtpData);

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

//  * Country code search function

  _onSearchChanged(String query) {
    setState(() {
      r = [];
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
          r.add(element);
        });
      }

      final phoneCode = element.phonecode?.toString().contains(filter);

      if (phoneCode == true) {
        setState(() {
          // r = [];
          r.add(element);
        });
      }
    });
  }
}
