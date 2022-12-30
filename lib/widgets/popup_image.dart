import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/utils/initPlatformState.dart';

class PopupImage extends StatefulWidget {
  final String? image;
  String? chatImage;
  PopupImage({
    required this.image,
    this.chatImage,
    Key? key,
  }) : super(key: key);

  @override
  State<PopupImage> createState() => _PopupImageState();
}

class _PopupImageState extends State<PopupImage> {
  bool loading = false;
  @override
  Widget build(context) {
    print(widget.image);
    final size = MediaQuery.of(context).size;
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              width: size.width * .9,
              child: CachedNetworkImage(
                // errorWidget: (context, url, error) {
                //   return Container(
                //     height: 80,
                //     width: size.width * .28,
                //     color: ColorManager.grayLight,
                //   );
                // },
                // imageBuilder: (context, imageProvider) => Container(
                //   width: size.width * .9,
                //   height: size.height * .7,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                //   ),
                // ),
                imageUrl: widget.chatImage ?? "$endPoint${widget.image}",
                fit: BoxFit.cover,
                // cacheManager: customCacheManager,
              ),
            ),
            Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: ColorManager.whiteColor,
                    child: Icon(
                      Icons.close,
                      color: ColorManager.errorRed,
                      size: 25,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  allowfunction(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await Hive.box("token").clear();
    callInitFunction(context);
  }

  callInitFunction(context) async {
    await initPlatformState(context);
  }
}
