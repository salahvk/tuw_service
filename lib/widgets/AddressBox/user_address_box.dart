// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/other%20User/show_user_address.dart';

class UserAddressBox extends StatefulWidget {
  UserAddress? userAddress;
  UserAddressBox({super.key, this.userAddress});

  @override
  State<UserAddressBox> createState() => _UserAddressBoxState();
}

class _UserAddressBoxState extends State<UserAddressBox> {
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
        ],
      ),
    );
  }
}
