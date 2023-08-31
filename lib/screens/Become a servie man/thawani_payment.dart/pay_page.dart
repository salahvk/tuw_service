import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/becomeServiceMan/payment_success.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/widgets/backbutton.dart';
import 'package:thawani_payment/class/status.dart';
import 'package:thawani_payment/thawani_payment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayPage extends StatefulWidget {
  final String serviceFee;
  final String validity;
  final String packageName;
  // final String validity;
  final int vat;
  var taxTotal;
  var amount;
  final String orderId;
  PayPage({
    super.key,
    required this.amount,
    required this.validity,
    required this.packageName,
    required this.orderId,
    required this.vat,
    required this.taxTotal,
    required this.serviceFee,
    // required this.validity,
  });

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    print(widget.amount);

    final conAmount = (widget.amount * 1000).toInt();
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final user = Provider.of<DataProvider>(context, listen: false)
        .viewProfileModel
        ?.userdetails;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(str.thawani_payment,
      //       style: getRegularStyle(color: ColorManager.grayDark, fontSize: 16)),
      // ),
      body: SafeArea(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 5, 14, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BackButton2(),
                    Spacer(),
                    CircleAvatar(
                        backgroundColor: Color(0xff08dc2c),
                        child: Image.asset(
                          'assets/logo/app-logo-T.jpg',
                          height: 30,
                          width: 30,
                        ))
                  ],
                ),
                Text(str.thawani_payment,
                    style: getRegularStyle(
                        color: ColorManager.grayDark, fontSize: 16)),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        color: Colors.grey.shade300,
                        // offset: const Offset(5, 8.5),
                      ),
                    ],
                  ),
                  width: size.width,
                  // height: 190,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.packageName}",
                              style: getSemiBoldtStyle(
                                  color: ColorManager.black, fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("${str.su_service_fee} : ${widget.serviceFee}",
                                style: getRegularStyle(
                                    color: ColorManager.grayDark,
                                    fontSize: 16)),
                            SizedBox(
                              height: 10,
                            ),
                            Text("${str.validity} : ${widget.validity}",
                                style: getRegularStyle(
                                    color: ColorManager.grayDark,
                                    fontSize: 16)),
                            SizedBox(
                              height: 10,
                            ),
                            // Text("Validity : $validity"),
                            Text("${str.tax_total}  : ${widget.taxTotal}",
                                style: getRegularStyle(
                                    color: ColorManager.grayDark, fontSize: 16)
                                // style: getRegularStyle(
                                //     color: ColorManager.grayDark, fontSize: 12)
                                ),
                            SizedBox(
                              height: 10,
                            )
                            // Spacer(),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                        //   child: Container(
                        //     height: 60,
                        //     width: double.infinity,
                        //     color: ColorManager.background,
                        //     child: Center(
                        //         child: Text(
                        //             "${str.su_grand_total}: ${widget.amount}")),
                        //   ),
                        // )
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            color: ColorManager.background,
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${str.su_grand_total} : ",
                                  style: getMediumtStyle(
                                      color: ColorManager.black, fontSize: 16),
                                ),
                                Text(
                                  "${widget.amount} ",
                                  style: getBoldtStyle(
                                      color: ColorManager.primary,
                                      fontSize: 16),
                                ),
                                Text(
                                  "OMR",
                                  style: getBoldtStyle(
                                      color: Colors.grey, fontSize: 14),
                                )
                              ],
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                isLoading
                    ? Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                        ),
                      )
                    : SizedBox(
                        width: 200,
                        height: 50,
                        child: ThawaniPayBtn(
                          testMode: false,
                          buttonStyle: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorManager.primary),
                          ),
                          // api: 'rRQ26GcsZzoEhbrP2HZvLYDbn9C9et',
                          // pKey: 'HGvTMLDssJghr9tlN9gr4DVYt0qyBy',
                          // successUrl: "https://company.com/success",
                          // cancelUrl: "https://company.com/cancel",
                          successUrl: thawaniPaymentSuccess,
                          api: 'LqZ2Ma9doGSkfIJPKssA3lPPKnhfRJ',
                          pKey: 'sCyctJWWAtRZ6i3nsEe8fGEsYMa2Si',
                          cancelUrl: thawaniPaymentfailed,
                          metadata: {
                            "Customer Name":
                                "${user?.firstname} ${user?.lastname}",
                            "Customer PhoneNumber": "${user?.phone}",
                            "Customer Email": "${user?.email}"
                          },
                          clintID: widget.orderId,

                          onError: (e) {
                            print(e);
                            print("object");
                          },
                          products: [
                            {
                              "name": widget.packageName,
                              "quantity": 1,
                              "unit_amount": conAmount,
                            },
                          ],
                          onCreate: (v) {
                            setState(() {
                              isLoading = true;
                            });
                            print(v);
                          },
                          onCancelled: (v) {
                            print(v.data);
                            getFail(context, v);
                          },
                          onPaid: (v) {
                            print(v.data);
                            getOrderSuccessData(context, v);
                          },
                          // child: const Text("data"),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getOrderSuccessData(BuildContext context, StatusClass v) async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    // setState(() {
    //   isLoading = true;
    // });
    await getThawaniPaymentSuccess(
        context, provider.placeOrder?.orderId.toString(), 'success', v);
    await viewProfile(context);

    // setState(() {
    //   isLoading = false;
    // });
    Navigator.pushNamed(context, Routes.paymentSuccessfull);
  }

  getFail(BuildContext context, StatusClass v) async {
    await getThawaniFailed(context, v);
    Navigator.pushNamed(context, Routes.payFailPage);
  }
}
