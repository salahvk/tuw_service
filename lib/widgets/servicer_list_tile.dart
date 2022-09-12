import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class ServicerListTile extends StatelessWidget {
  const ServicerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.grey.shade300,
            offset: const Offset(5, 8.5),
          ),
        ],
      ),
      width: size.width,
      height: 120,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorManager.whiteColor),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
              width: size.width * 0.3,
              height: 120,
              child: Center(
                child: CircleAvatar(
                  radius: 43,
                  backgroundColor: ColorManager.whiteColor,
                  child: CircleAvatar(
                    radius: 40,
                    child: Image.asset(ImageAssets.profileIcon),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            SizedBox(
              width: size.width * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Akhil Mahesh',
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: 16)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Car Servicer',
                      style: getRegularStyle(
                          color: const Color.fromARGB(255, 173, 173, 173),
                          fontSize: 15)),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 4,
                        itemSize: 20,
                        ignoreGestures: true,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.50),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImageAssets.tools),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("Engin Worker",
                          style: getRegularStyle(
                              color: const Color.fromARGB(255, 173, 173, 173),
                              fontSize: 15))
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                width: size.width * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.favorite,
                      size: 23,
                      color: ColorManager.primary,
                    ),
                    Column(
                      children: [
                        Image.asset(ImageAssets.car),
                        Text("30 KM",
                            style: getMediumtStyle(
                                color: const Color.fromARGB(255, 173, 173, 173),
                                fontSize: 10))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
