import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class CustomStepper extends StatelessWidget {
  final int num;
  const CustomStepper({Key? key, required this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Profile",
                style: getMediumtStyle(
                    color: ColorManager.paymentPageColor1, fontSize: 10),
              ),
              const SizedBox(
                height: 3,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 85,
                    height: 2.2,
                    color: num == 1 || num == 2 || num == 3
                        ? ColorManager.primary
                        : ColorManager.whiteColor,
                  ),
                  const Positioned(
                    // left: 30,
                    // bottom: 1,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: ColorManager.primary,
                      child: CircleAvatar(
                        radius: 2,
                        backgroundColor: ColorManager.whiteColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              Text("Choose Service",
                  style: getMediumtStyle(
                      color: ColorManager.paymentPageColor1, fontSize: 10)),
              const SizedBox(
                height: 3,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 85,
                    height: 2.2,
                    color: num == 2 || num == 3
                        ? ColorManager.primary
                        : ColorManager.whiteColor,
                  ),
                  const Positioned(
                    // left: 30,
                    // bottom: 1,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: ColorManager.primary,
                      child: CircleAvatar(
                        radius: 2,
                        backgroundColor: ColorManager.whiteColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              Text("Payment",
                  style: getMediumtStyle(
                      color: ColorManager.paymentPageColor1, fontSize: 10)),
              const SizedBox(
                height: 3,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 85,
                    height: 2.2,
                    color: num == 3
                        ? ColorManager.primary
                        : ColorManager.whiteColor,
                  ),
                  const Positioned(
                    // left: 30,
                    // bottom: 1,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: ColorManager.primary,
                      child: CircleAvatar(
                        radius: 2,
                        backgroundColor: ColorManager.whiteColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
