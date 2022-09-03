import 'package:flutter/cupertino.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class PaymentListTile extends StatelessWidget {
  final String text1;
  final String text2;
  const PaymentListTile({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: .4, color: ColorManager.grayLight),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text1,
                style: getRegularStyle(
                    color: ColorManager.paymentPageColor2, fontSize: 16)),
            Text(text2,
                style: getRegularStyle(
                    color: ColorManager.paymentPageColor2, fontSize: 16))
          ],
        ),
      ),
    );
  }
}
