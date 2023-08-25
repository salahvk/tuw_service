// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';
import 'package:social_media_services/API/becomeServiceMan/coupenCode.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/model/get_child_service.dart';
import 'package:social_media_services/model/place_order.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive_width.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/thawani_payment.dart/pay_page.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/widgets/backbutton.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/custom_stepper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/widgets/monthly_plan.dart';
import 'package:social_media_services/widgets/title_widget.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_services/widgets/top_logo.dart';

class PaymentServicePage extends StatefulWidget {
  const PaymentServicePage({Key? key}) : super(key: key);

  @override
  State<PaymentServicePage> createState() => _PaymentServicePageState();
}

class _PaymentServicePageState extends State<PaymentServicePage> {
  String? selectedValue;

  bool isTickSelected = false;
  IsCodeAvailable status = IsCodeAvailable.none;
  Packages? packages;
  bool isPackageSelected = false;

  bool coupenLoading = false;
  bool value = true;
  bool isPaymentLoading = false;
  bool isVisible = false;
  bool getCodeLoading = false;

  DateTime selectedDate = DateTime.now();

  int _selectedIndex = 2;
  int taxTotal = 0;
  int tax = 0;
  final List<Widget> _screens = [const ServiceHomePage(), const MessagePage()];
  var grandTotal;
  double taxTotalAmount = 0;

  String lang = '';

  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   getCoupenCodeList(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final w = MediaQuery.of(context).size.width;
    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);
    taxTotal = 0;
    // taxTotalAmount = 0;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawer: SizedBox(
        height: size.height * 0.825,
        width: mobWth
            ? w * 0.6
            : smobWth
                ? w * .7
                : w * .75,
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
              child: Column(
                children: [
                  Row(
                    children: [
                      BackButton2(),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TopLogo(),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 0,
                          ),
                          const CustomStepper(num: 3),
                          // MandatoryHeader(heading: str.ps_card),
                          // TextFieldProfileService(
                          //   controller:
                          //       PaymentServiceControllers.cardHolderController,
                          //   hintText: str.ps_card_h,
                          // ),
                          // MandatoryHeader(heading: str.ps_card_no),
                          // TextFieldProfileService(
                          //     controller:
                          //         PaymentServiceControllers.cardNumberController,
                          //     hintText: str.ps_card_no_h,
                          //     type: TextInputType.number),

                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         MandatoryHeader(heading: str.ps_ex),
                          //         Padding(
                          //           padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          //           child: Container(
                          //             width: size.width * 0.44,
                          //             decoration: BoxDecoration(
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   blurRadius: 10.0,
                          //                   color: Colors.grey.shade300,
                          //                   // offset: const Offset(5, 8.5),
                          //                 ),
                          //               ],
                          //             ),
                          //             child: TextField(
                          //               style: const TextStyle(),
                          //               readOnly: true,
                          //               controller: PaymentServiceControllers
                          //                   .dateController,
                          //               decoration: InputDecoration(
                          //                   suffixIcon: InkWell(
                          //                     onTap: () => _selectDate(context),
                          //                     child: const Icon(
                          //                       Icons.calendar_month,
                          //                       color: ColorManager.primary,
                          //                     ),
                          //                   ),
                          //                   hintText: str.ps_ex,
                          //                   hintStyle: getRegularStyle(
                          //                       color: const Color.fromARGB(
                          //                           255, 173, 173, 173),
                          //                       fontSize: 14)),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       // mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          //           child: MandatoryHeader(heading: str.ps_cvv),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               SizedBox(
                          //                   width: size.width * .44,
                          //                   child: TextFieldProfileService(
                          //                       controller:
                          //                           PaymentServiceControllers
                          //                               .cvvCodeController,
                          //                       hintText: str.ps_cvv_h,
                          //                       type: TextInputType.number)),
                          //             ],
                          //           ),
                          //         )
                          //       ],
                          //     )
                          //   ],
                          // ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: TitleWidget(name: str.ps_coupon),
                          ),
                          // TextFieldProfileService(
                          //     controller:
                          //         PaymentServiceControllers.couponController,
                          //     hintText: str.ps_coupon_h,
                          //     type: TextInputType.number),
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
                                // focusNode: nfocus,
                                style: const TextStyle(),
                                onChanged: (value) {
                                  // searchCoupenCode(value);
                                },
                                controller:
                                    PaymentServiceControllers.couponController,
                                // keyboardType: type,
                                decoration: InputDecoration(
                                    suffixIcon: SizedBox(
                                      width: size.width * .5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            // width: size.width * .4,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding: coupenLoading
                                                      ? const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 35,
                                                          vertical: 0)
                                                      : const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20,
                                                          vertical: 0),
                                                ),
                                                onPressed: redeem,
                                                child: coupenLoading
                                                    ? const SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child:
                                                            CircularProgressIndicator())
                                                    : Text(
                                                        str.redeem,
                                                        style: getSemiBoldtStyle(
                                                            color: ColorManager
                                                                .whiteColor,
                                                            fontSize: 15),
                                                      )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: getCoupenFunction,
                                            child: getCodeLoading
                                                ? const SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ))
                                                : Icon(
                                                    isVisible
                                                        ? Icons
                                                            .arrow_drop_up_outlined
                                                        : Icons
                                                            .arrow_drop_down_circle,
                                                    color:
                                                        ColorManager.primary2,
                                                  ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    hintText: str.ps_coupon_h,
                                    hintStyle: getRegularStyle(
                                        color: const Color.fromARGB(
                                            255, 173, 173, 173),
                                        fontSize: 15)),
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                  visible: isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(5)),
                                    width: w * .5,
                                    height: 100,
                                    child: ListView.builder(
                                      itemCount: provider
                                          .coupenCodeModel?.coupons?.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              // color: ColorManager.primary2,
                                              // height: 30,
                                              child: Text(provider
                                                      .coupenCodeModel
                                                      ?.coupons?[index]
                                                      .code ??
                                                  ''),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                            ],
                          ),
                          provider.customerChildSer!.packages!.isNotEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: SizedBox(
                                    height: size.height * .125,
                                    child: Center(
                                      child: ListView.builder(
                                        // physics:
                                        //     const NeverScrollableScrollPhysics(),
                                        // shrinkWrap: true,
                                        itemCount: provider.customerChildSer
                                                ?.packages?.length ??
                                            0,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  isPackageSelected = true;
                                                  taxTotal = 0;
                                                  taxTotalAmount = 0;
                                                  packages = provider
                                                      .customerChildSer
                                                      ?.packages?[index];

                                                  if (packages!
                                                      .taxDetails!.isEmpty) {
                                                    setState(() {
                                                      taxTotalAmount = 0;
                                                    });

                                                    if (packages?.offerPrice !=
                                                        null) {
                                                      grandTotal = packages
                                                          ?.offerPrice
                                                          ?.toDouble();
                                                    } else {
                                                      print(
                                                          "This value is Null");
                                                      grandTotal =
                                                          packages?.amount;
                                                    }
                                                  }
                                                });

                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 100));
                                                setState(() {});
                                              },
                                              child: Center(
                                                child: MonthlyPlan(
                                                  len: provider.customerChildSer
                                                          ?.packages?.length ??
                                                      0,
                                                  size: size,
                                                  plan: provider
                                                          .customerChildSer
                                                          ?.packages![index]
                                                          .packageName ??
                                                      '',
                                                  amount: provider
                                                          .customerChildSer
                                                          ?.packages![index]
                                                          .amount
                                                          .toString() ??
                                                      '',
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          // SizedBox(
                          //   height: 50,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) {
                          //       return Padding(
                          //           padding: const EdgeInsets.all(2.0),
                          //           child: Container(
                          //             width: 50,
                          //             height: 50,
                          //             color: ColorManager.errorRed,
                          //           ));
                          //     },
                          //     itemCount: 15,
                          //   ),
                          // ),
                          isPackageSelected
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14, 20, 14, 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(packages?.packageName ?? '',
                                                style: getBoldtStyle(
                                                    color: ColorManager.black,
                                                    fontSize: 18)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                      "${str.su_service_fee} :",
                                                      style: getRegularStyle(
                                                          color: ColorManager
                                                              .grayDark,
                                                          fontSize: 16)),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                    packages?.amount
                                                            .toString() ??
                                                        '',
                                                    style: getRegularStyle(
                                                        color: ColorManager
                                                            .grayDark,
                                                        fontSize: 16)),
                                              ],
                                            ),
                                            packages?.offerPrice != null
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 5, 0, 5),
                                                    child: Text(
                                                        "${str.su_discount}     : ${packages?.offerPrice ?? ''}",
                                                        style: getRegularStyle(
                                                            color: ColorManager
                                                                .grayDark,
                                                            fontSize: 16)),
                                                  )
                                                : Container(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                        "${str.validity} :",
                                                        style: getRegularStyle(
                                                            color: ColorManager
                                                                .grayDark,
                                                            fontSize: 16)),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                      "${packages?.validity ?? ''}",
                                                      style: getRegularStyle(
                                                          color: ColorManager
                                                              .grayDark,
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ),
                                            ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                taxTotal = taxTotal +
                                                    (packages
                                                            ?.taxDetails?[index]
                                                            .percentage ??
                                                        0);

                                                taxTotalAmount =
                                                    (packages?.offerPrice ??
                                                            packages?.amount) *
                                                        (taxTotal / 100);
                                                // if (packages?.offerPrice != null) {
                                                grandTotal =
                                                    (packages?.offerPrice ??
                                                            packages?.amount) +
                                                        taxTotalAmount;
                                                // }

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 5),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                            "${packages?.taxDetails![index].taxName} :",
                                                            style: getRegularStyle(
                                                                color:
                                                                    ColorManager
                                                                        .grayDark,
                                                                fontSize: 16)),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                          '${packages?.taxDetails![index].percentage ?? ''} %',
                                                          style: getRegularStyle(
                                                              color:
                                                                  ColorManager
                                                                      .grayDark,
                                                              fontSize: 16)),
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount: packages
                                                      ?.taxDetails?.length ??
                                                  0,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                      "${str.tax_total} :",
                                                      style: getRegularStyle(
                                                          color: ColorManager
                                                              .grayDark,
                                                          fontSize: 16)),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text("$taxTotalAmount",
                                                    style: getRegularStyle(
                                                        color: ColorManager
                                                            .grayDark,
                                                        fontSize: 16)),
                                              ],
                                            ),
                                            Text(
                                                packages?.packageDescription ??
                                                    '',
                                                style: getRegularStyle(
                                                    color: const Color.fromARGB(
                                                        255, 173, 173, 173),
                                                    fontSize: 16)),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              height: 60,
                                              width: double.infinity,
                                              color: ColorManager.background,
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${str.su_grand_total} : ",
                                                    style: getMediumtStyle(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    "$grandTotal ",
                                                    style: getBoldtStyle(
                                                        color: ColorManager
                                                            .primary,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.fromLTRB(
                                          28, 0, 28, 0)),
                                  onPressed: onContinue,
                                  child: !isPaymentLoading
                                      ?
                                      // Text(str.ps_pay,
                                      Text("Proceed",
                                          style: getRegularStyle(
                                              color: ColorManager.whiteText,
                                              fontSize: 16))
                                      : const SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator())),
                            ],
                          )
                        ],
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
        firstDate: DateTime.now(),
        lastDate: DateTime(2100, 8));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        PaymentServiceControllers.dateController.text =
            selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

// * Search Coupon Function

  searchCoupenCode(value) {
    if (value.length > 0) {
      setState(() {
        status = IsCodeAvailable.searching;
      });
    } else {
      setState(() {
        status = IsCodeAvailable.none;
      });
      return;
    }

    if (value.length >= 6) {
      final provider = Provider.of<DataProvider>(context, listen: false);
      // print(value);
      provider.coupenCodeModel?.coupons?.forEach((element) {
        final isIncluded = element.code?.contains(value);
        if (isIncluded == true) {
          setState(() {
            status = IsCodeAvailable.available;
          });
        } else {
          setState(() {
            status = IsCodeAvailable.notAvailable;
          });
        }
      });
    }
  }

  onContinue() {
    final str = AppLocalizations.of(context)!;
    // if (PaymentServiceControllers.cardHolderController.text.isEmpty) {
    //   showAnimatedSnackBar(context, str.ps_snack_card);
    // } else if (PaymentServiceControllers.cardNumberController.text.isEmpty) {
    //   showAnimatedSnackBar(context, str.ps_snack_card_no);
    // } else if (PaymentServiceControllers.dateController.text.isEmpty) {
    //   showAnimatedSnackBar(context, str.ps_snack_expiry);
    // } else if (PaymentServiceControllers.cvvCodeController.text.isEmpty) {
    //   showAnimatedSnackBar(context, str.ps_snack_cvv);
    // } else
    if (isPackageSelected == false) {
      showAnimatedSnackBar(context, str.ps_snack_package);
    } else {
      FocusManager.instance.primaryFocus?.unfocus();

      // setState(() {
      //   isPaymentLoading = false;
      // });

      placeOrder(context);
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Routes.paymentSuccessfull, (route) => false);
    }
  }

  placeOrder(BuildContext context) async {
    setState(() {
      isPaymentLoading = true;
    });
    final provider = Provider.of<DataProvider>(context, listen: false);
    final apiToken = Hive.box("token").get('api_token');
    if (apiToken == null) return;
    final fieldData = provider.viewProfileModel?.userdetails;
    // final url =
    //     "${paymentSuccess}firstname=${ProfileServiceControllers.firstNameController}&lastname=${ProfileServiceControllers.lastNameController}&civil_card_no=${ProfileServiceControllers.civilCardController}&dob=${ProfileServiceControllers.dateController}&gender=female&country_id=101&state=kerala&region=sdf&address=dfsdf&package_id=40&service_id=12&coupon_code=ABC&total_amount=100.00&total_tax_amount=0.00&coupon_discount=0.00&grand_total=100.00";
    final firstName = ProfileServiceControllers.firstNameController.text.isEmpty
        ? fieldData?.firstname ?? ''
        : ProfileServiceControllers.firstNameController.text;
    final lastName = ProfileServiceControllers.lastNameController.text.isEmpty
        ? fieldData?.lastname ?? ''
        : ProfileServiceControllers.lastNameController.text;
    final civilCardNo =
        ProfileServiceControllers.civilCardController.text.isEmpty
            ? fieldData?.civilCardNo ?? ''
            : ProfileServiceControllers.civilCardController.text;
    final dob = ProfileServiceControllers.dateController.text.isEmpty
        ? fieldData?.dob ?? ''
        : ProfileServiceControllers.dateController.text;
    final gender =
        provider.gender.isEmpty ? fieldData?.gender ?? '' : provider.gender;
    final state = ProfileServiceControllers.stateController.text.isEmpty
        ? fieldData?.state ?? ''
        : ProfileServiceControllers.stateController.text;
    final region = ProfileServiceControllers.regionController.text.isEmpty
        ? fieldData?.region ?? ''
        : ProfileServiceControllers.regionController.text;
    final address = ProfileServiceControllers.addressController.text.isEmpty
        ? fieldData?.about ?? ''
        : ProfileServiceControllers.addressController.text;
    final serviceId = provider.serviceId;
    final coupenCode = PaymentServiceControllers.couponController.text;
    final countryId = provider.selectedCountryId ??
        provider.viewProfileModel?.userdetails?.countryId;
    final packageId = packages?.id;

    final url =
        '${placeOrderApi}firstname=$firstName&lastname=$lastName&civil_card_no=$civilCardNo&dob=$dob&gender=$gender&country_id=${countryId.toString()}&state=$state&region=$region&address=$address&package_id=$packageId&service_id=$serviceId&coupon_code=$coupenCode&total_amount=${packages?.amount}&total_tax_amount=$taxTotalAmount&coupon_discount=0.00&grand_total=$grandTotal';
    try {
      print(packageId);
      print(url);
      // return;
      var response = await http.post(Uri.parse(url), headers: {
        "device-id": provider.deviceId ?? '',
        "api-token": apiToken
      });
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        log(response.body);
        if (jsonResponse['result'] == true) {
          // print(jsonResponse['order_id']);
          String orderId = jsonResponse['order_id'].toString();

          log(
            jsonResponse['message'],
          );

          // Navigator.push(context, MaterialPageRoute(builder: ((context) {
          //   return const PaymentSelection();
          // })));
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRight,
                  // child: PaymentScreen(
                  //   amount: grandTotal ?? 0,
                  //   // packages: packages!,
                  //   // taxTotalAmount: taxTotalAmount.toString(),
                  // )
                  child: PayPage(
                    packageName: packages?.packageName ?? '',
                    validity: packages?.validity ?? '',
                    amount: grandTotal ?? 0,
                    orderId: orderId,
                    serviceFee: (packages?.amount.toString() ?? ''),
                    taxTotal: taxTotalAmount,
                    // validity: packages?.validity ?? '',
                    vat: 4,
                  )));
          setState(() {
            isPaymentLoading = false;
          });

          final placeOrderData = PlaceOrder.fromJson(jsonResponse);
          provider.getPlaceOrderData(placeOrderData);
        } else {
          print(response.statusCode);
          showAnimatedSnackBar(
            context,
            jsonResponse['errors'],
          );

          setState(() {
            isPaymentLoading = false;
          });
        }
        // final childData = ChildServiceModel.fromJson(jsonResponse);
        // provider.childModelData(childData);
      } else {}
    } on Exception catch (e) {
      print(e);
    }
  }

  redeem() async {
    final str = AppLocalizations.of(context)!;
    setState(() {
      coupenLoading = true;
    });
    final code = PaymentServiceControllers.couponController.text;
    if (code.isEmpty) {
      showAnimatedSnackBar(context, str.ps_snack_coupen);
      setState(() {
        coupenLoading = false;
      });
      return;
    }
    await checkCoupenCode(context, code);
    setState(() {
      coupenLoading = false;
    });
  }

  // * Get Coupen Function

  getCoupenFunction() async {
    if (!isVisible) {
      setState(() {
        getCodeLoading = true;
      });
      final value = await getCoupenCodeList(context);
      setState(() {
        getCodeLoading = false;
      });
      if (value) {
        setState(() {
          isVisible = !isVisible;
        });
      }
    } else {
      setState(() {
        isVisible = false;
      });
    }
  }
}

enum IsCodeAvailable { none, searching, available, notAvailable }

// enum PackageStatus { none, first, second }
