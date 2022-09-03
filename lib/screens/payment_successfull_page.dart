import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/widgets/payment_custom_listTile.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    LottieBuilder.asset(
                      // fit: BoxFit.fitWidth,
                      ImageAssets.paymentSuccess,
                      repeat: false,
                    ),
                    Positioned(
                        bottom: 20,
                        // left: 2,
                        child: Column(
                          children: [
                            Text(
                              "Payment Successfull",
                              style: getBoldtStyle(
                                  color: ColorManager.primary, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Transaction no : #123456789",
                              style: getRegularStyle(
                                  color: ColorManager.paymentPageColor1,
                                  fontSize: 16),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Text(
                "Your payment was successfully processed.\nDetail of transaction are included",
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: ColorManager.paymentPageColor1, fontSize: 16),
              ),
              const SizedBox(
                height: 30,
              ),
              const PaymentListTile(text1: 'Date :', text2: '25/08/2022'),
              const PaymentListTile(
                  text1: "Service Fee :", text2: "\$135.00 OMR"),
              const PaymentListTile(
                  text1: 'Discount', text2: '\$7.00 OMR = 5%'),
              const PaymentListTile(
                text1: 'VAT',
                text2: '\$12.00 OMR = 8%',
              ),
              const PaymentListTile(
                text1: 'Mobile No :',
                text2: '+968 9526 123456',
              ),
              const PaymentListTile(
                text1: 'Exp Date :',
                text2: '25/09/2022',
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0)),
                      child: Text(
                        "BACK TO HOME",
                        style: getMediumtStyle(
                            color: ColorManager.whiteText, fontSize: 14),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0)),
                      child: Text(
                        "SAVE PDF",
                        style: getMediumtStyle(
                            color: ColorManager.whiteText, fontSize: 14),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
