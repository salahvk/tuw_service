import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class MonthlyPlan extends StatelessWidget {
  final String plan;
  final String amount;
  const MonthlyPlan({
    Key? key,
    required this.size,
    required this.plan,
    required this.amount,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        width: size.width * .44,
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
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan,
                    style: getMediumtStyle(
                        color: ColorManager.black, fontSize: 15)),
                Row(
                  children: [
                    Text(amount,
                        style: getSemiBoldtStyle(
                            color: ColorManager.primary, fontSize: 15)),
                    Text(" OMR",
                        style: getRegularStyle(
                            color: const Color.fromARGB(255, 173, 173, 173),
                            fontSize: 15))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
