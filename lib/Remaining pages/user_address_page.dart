import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/custom/links.dart';
import 'package:social_media_services/widgets/profile_image.dart';

class UserAddressPage extends StatelessWidget {
  const UserAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImage(
                iconSize: 12,
                profileSize: 40.5,
                iconRadius: 12,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Prithvina Raj",
                style: getBoldtStyle(color: ColorManager.black, fontSize: 13),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "PrithvinaRaj@gmail.com",
                style: getRegularStyle(
                    color: ColorManager.grayLight, fontSize: 13),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "+967 123 456 789",
                style: getRegularStyle(
                    color: ColorManager.grayLight, fontSize: 13),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    height: 100,
                    width: size.width,
                    child: CachedNetworkImage(
                      imageUrl: houseImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: size.width,
                decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Oman | Sohar"),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(5)),

                        // width: 30,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: ColorManager.whiteColor,
                              ),
                              Text(
                                "Home Locator",
                                style: getRegularStyle(
                                    color: ColorManager.whiteColor),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    height: 100,
                    width: size.width,
                    child: CachedNetworkImage(
                      imageUrl: googleMap,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Address",
                    style:
                        getBoldtStyle(color: ColorManager.black, fontSize: 14),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(5)),

                    // width: 30,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: ColorManager.whiteColor,
                          ),
                          Text(
                            "Add",
                            style:
                                getRegularStyle(color: ColorManager.whiteColor),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  children: [
                    Text(
                      "Home Address",
                      style: getRegularStyle(color: ColorManager.grayLight),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.grey.shade300,
                      offset: const Offset(5, 8.5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                  child: Text(
                    "Knowledge Oasis Muscat\nRusayl Housing Complex \nP.O Box:308, PC 124\nMuscat, Sultanate of Oman",
                    style: getRegularStyle(
                        color: ColorManager.grayLight, fontSize: 14),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
