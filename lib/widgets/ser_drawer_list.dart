import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';

class SerDrawerList extends StatefulWidget {
  final String image;
  // GestureTapCallback? onTap;

  const SerDrawerList({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<SerDrawerList> createState() => _SerDrawerListState();
}

class _SerDrawerListState extends State<SerDrawerList> {
  bool isTickSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: InkWell(
        onTap: () {
          setState(() {
            isTickSelected = !isTickSelected;
          });
        },
        child: ListTile(
          title: Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.white10.withAlpha(80)),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withAlpha(70),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  color: Colors.white.withOpacity(0.5),
                ),
                child:
                    isTickSelected ? Image.asset(ImageAssets.blackTick) : null,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Image.asset(
                    widget.image,
                    color: ColorManager.whiteColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
