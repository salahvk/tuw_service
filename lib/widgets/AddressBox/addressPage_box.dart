// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/user_address_show.dart';
import 'package:social_media_services/providers/data_provider.dart';

import 'package:social_media_services/screens/Address%20page/address_update.dart';
import 'package:social_media_services/screens/Google%20Map/view_location.dart';
import 'package:social_media_services/utils/diologue.dart';

class AddressBox extends StatefulWidget {
  UserAddress? userAddress;
  AddressBox({super.key, this.userAddress});

  @override
  State<AddressBox> createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  bool isLoading = false;
  String lang = '';
  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<DataProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: ViewLocationScreen(
                  latitude: widget.userAddress?.latitude,
                  longitude: widget.userAddress?.longitude),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Stack(
          children: [
            Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                // border: Border.all(
                //     color: ColorManager.paymentPageColor1, width: .5),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.grey.shade300,
                    offset: const Offset(5, 8.5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "$endPoint${widget.userAddress?.image}",
                    height: 200,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        // width: 25,
                        // height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.srcOver),
                              image: imageProvider,
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: lang != 'ar' ? 15 : null,
                    right: lang == 'ar' ? 15 : null,
                    bottom: 15,
                    child: Row(
                      children: [
                        //   padding: const EdgeInsets.fromLTRB(15, 100, 15, 20),
                        Text(
                          "${widget.userAddress?.addressName}\n${widget.userAddress?.address}\n${widget.userAddress?.homeNo}\n${widget.userAddress?.region}, ${widget.userAddress?.state}, ${widget.userAddress?.country}",
                          style: getRegularStyle(
                              color: ColorManager.whiteColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: lang == 'ar' ? null : 5,
              left: lang == 'ar' ? 5 : null,
              top: 5,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      provider.locality = null;
                      provider.addressLatitude = null;
                      provider.addressLongitude = null;
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return UserAddressUpdate(
                          userAddress: widget.userAddress!,
                        );
                      }));
                      // selectImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 3,
                            // offset: const Offset(2, 2.5),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          size: 12,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () async {
                      final addressId = widget.userAddress!.id.toString();
                      // print(addressId);
                      // setState(() {
                      //   isLoading = true;
                      // });
                      // await deleteAddressBox(addressId);
                      // setState(() {
                      //   isLoading = false;
                      // });
                      showDialog(
                          context: context,
                          builder: (context) =>
                              DialogueBox(addressId: addressId),
                          barrierDismissible: false);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (ctx) {
                      //   return UserAddressUpdate(
                      //     userAddress: userAddress[index],
                      //   );
                      // }));
                      // selectImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 3,
                            // offset: const Offset(2, 2.5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: isLoading
                            ? const SizedBox(
                                height: 8,
                                width: 8,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(
                                Icons.delete,
                                size: 12,
                                color: ColorManager.primary,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 130,
              right: lang == 'ar' ? null : 5,
              left: lang == 'ar' ? 5 : null,
              child: const Icon(Icons.navigate_next_sharp,
                  color: ColorManager.primary, size: 30),
            )
          ],
        ),
      ),
    );
  }
}
