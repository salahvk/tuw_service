// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:social_media_services/API/address/deleteUserAddress.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/user_address_show.dart';

import 'package:social_media_services/screens/Address%20page/address_update.dart';

class AddressBox extends StatefulWidget {
  UserAddress? userAddress;
  AddressBox({super.key, this.userAddress});

  @override
  State<AddressBox> createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Stack(
        children: [
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
                "${widget.userAddress?.addressName}\n${widget.userAddress?.address}\n${widget.userAddress?.homeNo}\n${widget.userAddress?.region}, ${widget.userAddress?.state}, ${widget.userAddress?.country}",
                style: getRegularStyle(
                    color: ColorManager.grayLight, fontSize: 14),
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
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
                    print(addressId);
                    setState(() {
                      isLoading = true;
                    });
                    await deleteAddressBox(addressId);
                    setState(() {
                      isLoading = false;
                    });

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
                              child: CircularProgressIndicator(strokeWidth: 2),
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
        ],
      ),
    );
  }

  deleteAddressBox(id) async {
    await deleteUserAddress(context, id);
    await viewProfile(context);
    Navigator.pushReplacementNamed(context, Routes.addressPage);
  }
}
