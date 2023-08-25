import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/get_favorites.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/serviceManLIst.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';

class ServicerListTile extends StatefulWidget {
  Serviceman? serviceman;
  ServicerListTile({super.key, required this.serviceman});

  @override
  State<ServicerListTile> createState() => _ServicerListTileState();
}

class _ServicerListTileState extends State<ServicerListTile> {
  bool isFavorite = false;
  String? apiToken;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final provider = Provider.of<DataProvider>(context, listen: false);
    // });
    apiToken = Hive.box("token").get('api_token');

    isFavorite = widget.serviceman?.featured == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.serviceman?.distance.toString().split('.');
    final size = MediaQuery.of(context).size;
    bool mob = Responsive.isMobile(context);
    final provider = Provider.of<DataProvider>(context, listen: false);

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
                            ? const AssetImage('assets/user.png')
                                as ImageProvider
                            : CachedNetworkImageProvider(
                                '$endPoint${widget.serviceman?.profilePic}'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: mob ? 65 : 45,
                  left: size.width * .06,
                  child: CircleAvatar(
                    radius: mob ? 8 : 6,
                    backgroundColor: widget.serviceman?.onlineStatus == 'online'
                        ? ColorManager.primary
                        : widget.serviceman?.onlineStatus == 'offline'
                            ? ColorManager.grayLight
                            : ColorManager.errorRed,
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
                      '${widget.serviceman?.firstname ?? ''} ${widget.serviceman?.lastname ?? ''}',
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: mob ? 16 : 10)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(widget.serviceman?.countryname ?? '',
                      style: getRegularStyle(
                          color: const Color.fromARGB(255, 173, 173, 173),
                          fontSize: mob ? 12 : 8)),
                  const SizedBox(
                    height: 4,
                  ),
                  // Text(widget.serviceman?.phone ?? '',
                  //     style: getRegularStyle(
                  //         color: const Color.fromARGB(255, 173, 173, 173),
                  //         fontSize: mob ? 15 : 10)),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
            const Spacer(),
            widget.serviceman?.distance == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: SizedBox(
                      width: size.width * 0.145,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                          isFavorite
                              ? addFavoritesListFun(
                                  context, widget.serviceman?.id)
                              : removeFavoritesListFun(
                                  context, widget.serviceman?.id);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            apiToken == null
                                ? Container()
                                : Icon(
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
                            Column(
                              children: [
                                Image.asset(provider.isTwoSelected
                                    ? ImageAssets.scooter
                                    : ImageAssets.car),
                                Text(s![0],
                                    style: getMediumtStyle(
                                        color: const Color.fromARGB(
                                            255, 173, 173, 173),
                                        fontSize: 12))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
