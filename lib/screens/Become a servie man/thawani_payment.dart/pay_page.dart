import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/becomeServiceMan/payment_success.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:thawani_payment/thawani_payment.dart';

class PayPage extends StatelessWidget {
  final double amount;
  const PayPage({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    print(amount);
    final conAmount = (amount * 1000).toInt();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thawani Payment'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 50,
              child: ThawaniPayBtn(
                testMode: true,
                api: 'rRQ26GcsZzoEhbrP2HZvLYDbn9C9et',
                pKey: 'HGvTMLDssJghr9tlN9gr4DVYt0qyBy',
                clintID: '1234',
                onError: (e) {
                  print(e);
                },
                products: [
                  {
                    "name": "product 1",
                    "quantity": 1,
                    "unit_amount": conAmount
                  },
                  // {"name": "product 2", "quantity": 1, "unit_amount": 200}
                ],
                onCreate: (v) {
                  print(v);
                },
                onCancelled: (v) {
                  print(v);
                  Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (builder) => const C()));
                },
                onPaid: (v) {
                  print(v.data);
                  getOrderSuccessData(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (builder) => const V()));
                },
                // child: const Text("data"),
              ),
            )
          ],
        ),
      ),
    );
  }

  getOrderSuccessData(
    BuildContext context,
  ) async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    // setState(() {
    //   isLoading = true;
    // });
    await getPaymentSuccess(
        context, provider.placeOrder?.orderId.toString(), 'success');
    await viewProfile(context);

    // setState(() {
    //   isLoading = false;
    // });
    Navigator.pushNamed(context, Routes.paymentSuccessfull);
  }
}
