import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/home/get_service_man.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/providers/data_provider.dart';

class SerDrawerList extends StatefulWidget {
  final String image;
  final String title;
  final String title2;
  final int id;
  // bool isResetSelected = false;
  // GestureTapCallback? onTap;

  const SerDrawerList(
      {Key? key,
      required this.image,
      required this.title,
      this.id = 0,
      required this.title2})
      : super(key: key);

  @override
  State<SerDrawerList> createState() => _SerDrawerListState();
}

class _SerDrawerListState extends State<SerDrawerList> {
  bool isTickSelected = false;
  @override
  void initState() {
    super.initState();

    // if (widget.isResetSelected == true) {
    //   setState(() {
    //     widget.isResetSelected = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: false);

    // print(widget.isResetSelected);

    widget.key;
    return SizedBox(
      height: 35,
      child: InkWell(
        onTap: () async {
          setState(() {
            isTickSelected = !isTickSelected;
          });

          // }
          if (isTickSelected == true) {
            widget.title.contains('Four')
                ? provider.isTwoSelected = false
                : true;
          }
          if (isTickSelected == false) {
            widget.title.contains('Four')
                ? provider.isFourWheelerSelected = false
                : true;
            widget.title.contains('Two')
                ? provider.isTwoWheelerSelected = false
                : true;
          } else {
            widget.title.contains('Four')
                ? provider.isFourWheelerSelected = true
                : false;
            widget.title.contains('Two')
                ? provider.isTwoWheelerSelected = true
                : false;
          }

          await searchServiceMan(
              context,
              widget.id.toString(),
              provider.servicerSelectedCountry,
              ServiceControllers.stateController.text,
              ServiceControllers.regionController.text,
              ServiceControllers.servicerController.text,
              provider.isFourWheelerSelected && provider.isTwoWheelerSelected
                  ? ''
                  : provider.isFourWheelerSelected
                      ? 'four wheeler'
                      : provider.isTwoWheelerSelected
                          ? 'two wheeler'
                          : '');
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
                child: isTickSelected == true ||
                        (provider.isFourWheelerSelected &&
                            widget.title.contains('Four')) ||
                        (provider.isTwoWheelerSelected &&
                            widget.title.contains('Two'))
                    ? Image.asset(ImageAssets.blackTick)
                    : null,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8, right: 10),
                  child: SizedBox(
                    width: 20,
                    child: Image.asset(
                      widget.image,
                      color: ColorManager.whiteColor,
                    ),
                  )),
              Text(widget.title2,
                  style: getRegularStyle(
                    color: ColorManager.whiteColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
