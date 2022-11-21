import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/serviceManLIst.dart';
import 'package:social_media_services/responsive/responsive.dart';

class ServicerListTile extends StatefulWidget {
  Serviceman? serviceman;
  ServicerListTile({super.key, required this.serviceman});

  @override
  State<ServicerListTile> createState() => _ServicerListTileState();
}

class _ServicerListTileState extends State<ServicerListTile> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final s = widget.serviceman?.distance.toString().split('.');
    final size = MediaQuery.of(context).size;
    bool mob = Responsive.isMobile(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.grey.shade200,
            offset: const Offset(5, 8.5),
          ),
        ],
      ),
      width: size.width,
      height: Responsive.isMobile(context) ? 120 : 80,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorManager.whiteColor),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    // color: ColorManager.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6)),
                  ),
                  width: size.width * 0.3,
                  height: mob ? 120 : 80,
                  child: Center(
                    child: CircleAvatar(
                      radius: mob ? 43 : 30,
                      backgroundColor: mob ? ColorManager.whiteColor : null,
                      child: CircleAvatar(
                        radius: mob ? 40 : 20,
                        // backgroundColor: ColorManager.grayDark,
                        backgroundImage: widget.serviceman?.profilePic == null
                            ? const AssetImage(ImageAssets.profileIcon)
                                as ImageProvider
                            : CachedNetworkImageProvider(
                                '$endPoint${widget.serviceman?.profilePic}'),

                        // CachedNetworkImage(
                        //     imageUrl: '$endPoint${serviceman?.profilePic}',
                        //     imageBuilder: (context, imageProvider) => Container(
                        //           // width: 25,
                        //           // height: 20,
                        //           decoration: BoxDecoration(
                        //             // shape: BoxShape.circle,
                        //             image: DecorationImage(
                        //                 image: imageProvider,
                        //                 fit: BoxFit.cover),
                        //           ),
                        //         ),
                        //     fit: BoxFit.cover,
                        //     errorWidget: (context, url, error) => Image.asset(
                        //           ImageAssets.profileIcon,
                        //           fit: BoxFit.cover,
                        //         )),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: mob ? 65 : 45,
                  left: size.width * .06,
                  child: CircleAvatar(
                    radius: mob ? 8 : 6,
                    backgroundColor: ColorManager.primary,
                  ),
                )
              ],
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
                  Text(
                      '${widget.serviceman?.firstname} ${widget.serviceman?.lastname}',
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: mob ? 16 : 10)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(widget.serviceman?.phone ?? '',
                      style: getRegularStyle(
                          color: const Color.fromARGB(255, 173, 173, 173),
                          fontSize: mob ? 15 : 10)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(widget.serviceman?.about ?? '',
                      style: getRegularStyle(
                          color: const Color.fromARGB(255, 173, 173, 173),
                          fontSize: mob ? 15 : 10)),
                  const SizedBox(
                    height: 4,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     RatingBar.builder(
                  //       initialRating: 4,
                  //       minRating: 1,
                  //       direction: Axis.horizontal,
                  //       allowHalfRating: true,
                  //       itemCount: 4,
                  //       itemSize: mob ? 20 : 12,
                  //       ignoreGestures: true,
                  //       itemPadding:
                  //           const EdgeInsets.symmetric(horizontal: 2.50),
                  //       itemBuilder: (context, _) => const Icon(
                  //         Icons.star,
                  //         color: Colors.amber,
                  //       ),
                  //       onRatingUpdate: (rating) {
                  //         print(rating);
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Image.asset(ImageAssets.tools),
                  //     const SizedBox(
                  //       width: 5,
                  //     ),
                  //     Text("Engin Worker",
                  //         style: getRegularStyle(
                  //             color: const Color.fromARGB(255, 173, 173, 173),
                  //             fontSize: mob ? 15 : 10))
                  //   ],
                  // )
                ],
              ),
            ),
            const Spacer(),
            widget.serviceman?.distance == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: SizedBox(
                      width: size.width * 0.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              shadows: const [
                                Shadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12,
                                  offset: Offset(0, 3.5),
                                ),
                              ],
                              size: mob ? 23 : 15,
                              color: isFavorite
                                  ? ColorManager.primary2
                                  : Colors.black12,
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset(ImageAssets.car),
                              Text('${s![0]} km',
                                  style: getMediumtStyle(
                                      color: const Color.fromARGB(
                                          255, 173, 173, 173),
                                      fontSize: 12))
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
