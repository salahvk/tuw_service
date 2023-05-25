import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/becomeServiceMan/payment_success.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:thawani_payment/class/status.dart';
import 'package:thawani_payment/thawani_payment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    print(amount);
    final conAmount = (amount * 1000).toInt();
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final user = Provider.of<DataProvider>(context, listen: false)
        .viewProfileModel
        ?.userdetails;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thawani Payment'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
                height: 190,
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
                          Text(
                            "$packageName",
                            style: getSemiBoldtStyle(
                                color: ColorManager.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("${str.su_service_fee} : $serviceFee"),
                          SizedBox(
                            height: 10,
                          ),
                          Text("${str.validity} : $validity"),
                          SizedBox(
                            height: 10,
                          ),
                          // Text("Validity : $validity"),
                          Text(
                            "${str.tax_total}  : $taxTotal",
                            // style: getRegularStyle(
                            //     color: ColorManager.grayDark, fontSize: 12)
                          ),
                          // Spacer(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          color: ColorManager.background,
                          child: Center(
                              child: Text("${str.su_grand_total}: $amount")),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  print("object");
                },
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ThawaniPayBtn(
                    testMode: false,
                    // api: 'rRQ26GcsZzoEhbrP2HZvLYDbn9C9et',
                    // pKey: 'HGvTMLDssJghr9tlN9gr4DVYt0qyBy',
                    // successUrl: "https://company.com/success",
                    // cancelUrl: "https://company.com/cancel",
                    successUrl: thawaniPaymentSuccess,
                    api: 'LqZ2Ma9doGSkfIJPKssA3lPPKnhfRJ',
                    pKey: 'sCyctJWWAtRZ6i3nsEe8fGEsYMa2Si',
                    cancelUrl: thawaniPaymentfailed,
                    metadata: {
                      "Customer Name": "${user?.firstname} ${user?.lastname}",
                      "Customer PhoneNumber": "${user?.phone}",
                      "Customer Email": "${user?.email}"
                    },
                    clintID: orderId,

                    onError: (e) {
                      print(e);
                      print("object");
                    },
                    products: [
                      {
                        "name": packageName,
                        "quantity": 1,
                        "unit_amount": conAmount,
                      },
                    ],
                    onCreate: (v) {
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
                ),
              )
            ],
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
