import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/demo/payment_failed.dart';

class PaymentSelection extends StatelessWidget {
  const PaymentSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.paymentSuccessfull);
                    },
                    child: const Text('Success')),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return const PaymentFailurePage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.errorRed),
                  child: const Text('Failure'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
