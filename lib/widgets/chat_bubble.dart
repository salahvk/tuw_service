import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class CustomChatBubble extends StatelessWidget {
  final bool isSendByme;
  final bool seen;
  String? text;
  final String time;
  String image;
  CustomChatBubble({
    Key? key,
    this.text,
    required this.image,
    required this.isSendByme,
    required this.time,
    required this.seen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment:
            isSendByme ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  isSendByme ? ColorManager.whiteColor : ColorManager.primary,
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
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  image.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 3),
                          child: SizedBox(
                            width: size.width * .35,
                            height: 100,
                            child: CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Text(
                          text ?? '',
                          style: getRegularStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          time,
                          style: getRegularStyle(
                              color: ColorManager.grayLight, fontSize: 9),
                        ),
                        Icon(
                          seen ? Icons.done_all : Icons.done,
                          color: ColorManager.black,
                          size: 12,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
