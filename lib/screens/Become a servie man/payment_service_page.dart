import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';
import 'package:social_media_services/API/becomeServiceMan/coupenCode.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/custom_stepper.dart';
import 'package:social_media_services/widgets/mandatory_widget.dart';
import 'package:social_media_services/widgets/monthly_plan.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/widgets/textField_Profile.dart';
import 'package:social_media_services/widgets/title_widget.dart';

class PaymentServicePage extends StatefulWidget {
  const PaymentServicePage({Key? key}) : super(key: key);

  @override
  State<PaymentServicePage> createState() => _PaymentServicePageState();
}

class _PaymentServicePageState extends State<PaymentServicePage> {
  String? selectedValue;

  bool isTickSelected = false;
  IsCodeAvailable status = IsCodeAvailable.none;
  PackageStatus packageStatus = PackageStatus.none;

  bool coupenLoading = false;
  bool value = true;

  DateTime selectedDate = DateTime.now();

  int _selectedIndex = 2;
  int taxTotal = 0;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];
  double grandTotal = 0;
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
    final package = provider.customerChildSer!.packages!.isNotEmpty
        ? (provider.customerChildSer?.packages?[
            packageStatus == PackageStatus.first
                ? 0
                : packageStatus == PackageStatus.second
                    ? 1
                    : 0])
        : null;

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
                      const CustomStepper(num: 3),
                      MandatoryHeader(heading: str.ps_card),
                      TextFieldProfileService(
                        controller:
                            PaymentServiceControllers.cardHolderController,
                        hintText: str.ps_card_h,
                      ),
                      MandatoryHeader(heading: str.ps_card_no),
                      TextFieldProfileService(
                          controller:
                              PaymentServiceControllers.cardNumberController,
                          hintText: str.ps_card_no_h,
                          type: TextInputType.number),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MandatoryHeader(heading: str.ps_ex),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  width: size.width * 0.44,
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
                                    controller: PaymentServiceControllers
                                        .dateController,
                                    decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                          onTap: () => _selectDate(context),
                                          child: const Icon(
                                            Icons.calendar_month,
                                            color: ColorManager.primary,
                                          ),
                                        ),
                                        hintText: str.ps_ex,
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: MandatoryHeader(heading: str.ps_cvv),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: size.width * .44,
                                        child: TextFieldProfileService(
                                            controller:
                                                PaymentServiceControllers
                                                    .cvvCodeController,
                                            hintText: str.ps_cvv_h,
                                            type: TextInputType.number)),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),

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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        // width: size.width * .4,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: coupenLoading
                                                  ? const EdgeInsets.symmetric(
                                                      horizontal: 35,
                                                      vertical: 0)
                                                  : const EdgeInsets.symmetric(
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
                                                    'Redeem',
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
                                        onTap: () {
                                          getCoupenCodeList(context);
                                          print('object');
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down_circle,
                                          color: ColorManager.primary2,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                // suffix: status == IsCodeAvailable.searching
                                //     ? const SizedBox(
                                //         width: 25,
                                //         height: 25,
                                //         child: CircularProgressIndicator(
                                //           strokeWidth: 3,
                                //         ))
                                //     : status == IsCodeAvailable.available
                                //         ? const SizedBox(
                                //             width: 25,
                                //             height: 25,
                                //             child: Icon(
                                //               Icons.done,
                                //               color: ColorManager.primary,
                                //             ))
                                //         : status == IsCodeAvailable.notAvailable
                                //             ? const SizedBox(
                                //                 width: 25,
                                //                 height: 30,
                                //                 child: Icon(
                                //                   Icons.close,
                                //                   color: ColorManager.errorRed,
                                //                 ))
                                //             : null,
                                hintText: str.ps_coupon_h,
                                hintStyle: getRegularStyle(
                                    color: const Color.fromARGB(
                                        255, 173, 173, 173),
                                    fontSize: 15)),
                          ),
                        ),
                      ),

                      // * Region
                      provider.customerChildSer!.packages!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            packageStatus = PackageStatus.first;
                                          });
                                          print(packageStatus);
                                        },
                                        child: MonthlyPlan(
                                          size: size,
                                          plan: provider.customerChildSer
                                                  ?.packages![0].packageName ??
                                              '',
                                          amount: provider.customerChildSer
                                                  ?.packages![0].amount
                                                  .toString() ??
                                              '',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            packageStatus =
                                                PackageStatus.second;
                                          });
                                          print(packageStatus);
                                        },
                                        child: MonthlyPlan(
                                          size: size,
                                          plan: provider.customerChildSer
                                                  ?.packages![1].packageName ??
                                              '',
                                          amount: provider.customerChildSer
                                                  ?.packages![1].amount
                                                  .toString() ??
                                              '',
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      packageStatus != PackageStatus.none
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                                    padding: const EdgeInsets.fromLTRB(
                                        14, 20, 14, 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            provider
                                                    .customerChildSer
                                                    ?.packages![packageStatus ==
                                                            PackageStatus.first
                                                        ? 0
                                                        : packageStatus ==
                                                                PackageStatus
                                                                    .second
                                                            ? 1
                                                            : 0]
                                                    .packageName ??
                                                '',
                                            style: getBoldtStyle(
                                                color: ColorManager.black,
                                                fontSize: 18)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Service Fee : ${package?.amount ?? ''}",
                                            style: getRegularStyle(
                                                color: ColorManager.grayDark,
                                                fontSize: 16)),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: Text(
                                              "Discount      : ${package?.offerPrice ?? ''}",
                                              style: getRegularStyle(
                                                  color: ColorManager.grayDark,
                                                  fontSize: 16)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
                                          child: Text(
                                              "Validity        : ${package?.validity ?? ''}",
                                              style: getRegularStyle(
                                                  color: ColorManager.grayDark,
                                                  fontSize: 16)),
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              taxTotal = package
                                                      ?.taxDetails?[index]
                                                      .percentage ??
                                                  0;
                                              grandTotal =
                                                  (package?.offerPrice)! -
                                                      ((package?.offerPrice)! /
                                                          taxTotal);
                                              setState(() {});
                                            });
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      "${package?.taxDetails![index].taxName}",
                                                      style: getRegularStyle(
                                                          color: ColorManager
                                                              .grayDark,
                                                          fontSize: 16)),
                                                  const SizedBox(
                                                    width: 65,
                                                  ),
                                                  Text(
                                                      ': ${package?.taxDetails![index].percentage ?? ''} %',
                                                      style: getRegularStyle(
                                                          color: ColorManager
                                                              .grayDark,
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            );
                                          },
                                          itemCount: provider
                                                  .customerChildSer
                                                  ?.packages![packageStatus ==
                                                          PackageStatus.first
                                                      ? 0
                                                      : packageStatus ==
                                                              PackageStatus
                                                                  .second
                                                          ? 1
                                                          : 0]
                                                  .taxDetails
                                                  ?.length ??
                                              0,
                                        ),
                                        Text(
                                            provider
                                                    .customerChildSer
                                                    ?.packages![packageStatus ==
                                                            PackageStatus.first
                                                        ? 0
                                                        : packageStatus ==
                                                                PackageStatus
                                                                    .second
                                                            ? 1
                                                            : 0]
                                                    .packageDescription ??
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
                                              child: Text(
                                                  "Grand Total: $grandTotal")),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 0, 28, 0)),
                              onPressed: onContinue,
                              child: Text(str.ps_pay,
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
    if (PaymentServiceControllers.cardHolderController.text.isEmpty) {
      showAnimatedSnackBar(context, "Please Enter A Card Holder Name");
    } else if (PaymentServiceControllers.cardNumberController.text.isEmpty) {
      showAnimatedSnackBar(context, "Please Enter A Card Number");
    } else if (PaymentServiceControllers.dateController.text.isEmpty) {
      showAnimatedSnackBar(context, "Please Enter Card Expiry Date");
    } else if (PaymentServiceControllers.cvvCodeController.text.isEmpty) {
      showAnimatedSnackBar(context, "Please Enter Your CVV Number");
    } else {
      FocusManager.instance.primaryFocus?.unfocus();

      // Navigator.pushNamedAndRemoveUntil(
      //     context, Routes.paymentSuccessfull, (route) => false);
    }
  }

  redeem() async {
    setState(() {
      coupenLoading = true;
    });
    final code = PaymentServiceControllers.couponController.text;
    if (code.isEmpty) {
      showAnimatedSnackBar(context, 'Please Enter a Coupen code to redeem');
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
}

enum IsCodeAvailable { none, searching, available, notAvailable }

enum PackageStatus { none, first, second }
