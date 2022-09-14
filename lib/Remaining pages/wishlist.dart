import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WishList",
          style: getMediumtStyle(color: ColorManager.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
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
                            height: 2,
                          ),
                          Text('Car Servicer',
                              style: getRegularStyle(
                                  color:
                                      const Color.fromARGB(255, 173, 173, 173),
                                  fontSize: 17)),
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
                                itemPadding: const EdgeInsets.symmetric(
                                    horizontal: 2.50),
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
                                      color: const Color.fromARGB(
                                          255, 173, 173, 173),
                                      fontSize: 15))
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.favorite,
                            color: ColorManager.primary,
                            size: 25,
                          )
                        ],
                      ),
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
