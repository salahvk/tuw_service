import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/chat_list.dart';
import 'package:social_media_services/responsive/responsive.dart';

class ChatListTile extends StatefulWidget {
  final Data? profileData;
  const ChatListTile({
    super.key,
    required this.profileData,
  });

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
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
      height: Responsive.isMobile(context) ? 100 : 80,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: ColorManager.whiteColor),
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
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
                            backgroundImage: widget.profileData?.profileImage ==
                                    null
                                ? const AssetImage('assets/user.png')
                                    as ImageProvider
                                : CachedNetworkImageProvider(
                                    '$endPoint${widget.profileData?.profileImage}'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      height: mob ? 55 : 35,
                      left: size.width * .045,
                      child: CircleAvatar(
                          radius: mob ? 8 : 6,
                          backgroundColor: ColorManager.primary),
                    )
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  // width: size.width * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.profileData?.firstname ?? '',
                          style: getRegularStyle(
                              color: ColorManager.black,
                              fontSize: mob ? 16 : 10)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(widget.profileData?.serviceName ?? '',
                          style: getRegularStyle(
                              color: const Color.fromARGB(255, 173, 173, 173),
                              fontSize: mob ? 12 : 8)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(widget.profileData?.messsage ?? '',
                          style: getRegularStyle(
                              color: const Color.fromARGB(255, 139, 138, 138),
                              fontSize: mob ? 11 : 7)),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 3,
            right: 10,
            child: Text('3 min ago',
                style: getRegularStyle(
                    color: const Color.fromARGB(255, 173, 173, 173),
                    fontSize: mob ? 10 : 7)),
          ),
          Positioned(
              right: 10,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: ColorManager.primary2,
                        borderRadius: BorderRadius.circular(2)),
                    child: Center(
                      child: Text(
                        '5',
                        style: getSemiBoldtStyle(
                            color: ColorManager.whiteColor, fontSize: 10),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
