import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/chat_list.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatListTile extends StatefulWidget {
  final MessageData? profileData;
  String? time;
  ChatListTile({super.key, required this.profileData, required this.time});

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  bool isFavorite = false;
  String lang = '';
  String? time;
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
    bool mob = Responsive.isMobile(context);
    // var dateTime = DateFormat("HH:mm")
    // .parse(widget.profileData?.createdAt?.substring(11, 16) ?? '', true);
    final str = AppLocalizations.of(context)!;
    // var date = DateFormat("dd-MM-yyyy").format(
    //     DateTime.parse(widget.profileData?.createdAt?.substring(0, 10) ?? ''));

    // var hour = dateTime.toLocal().hour;
    // var minute = dateTime.toLocal().minute;

    // var day = dateTime.toLocal().weekday;
    final provider = Provider.of<DataProvider>(context, listen: false);
    // if (DateTime.now().weekday == day) {
    //   setState(() {
    //     time = "$hour:$minute";
    //   });
    // } else if (DateTime.now().weekday == (day - 1)) {
    //   setState(() {
    //     time = "Yesterday";
    //   });
    // } else {
    //   setState(() {
    //     time = date;
    //   });
    // }
    // print(widget.profileData?.firstname);
    // print("object");
    // print(DateTime.now().weekday);
    // print(date);
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
                            backgroundImage: widget.profileData?.profilePic ==
                                    null
                                ? const AssetImage('assets/user.png')
                                    as ImageProvider
                                : CachedNetworkImageProvider(
                                    '$endPoint${widget.profileData?.profilePic}'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      height: mob ? 55 : 35,
                      left: size.width * .045,
                      child: CircleAvatar(
                        radius: mob ? 8 : 6,
                        backgroundColor:
                            widget.profileData?.onlineStatus == 'online'
                                ? ColorManager.primary
                                : widget.profileData?.onlineStatus == 'offline'
                                    ? ColorManager.grayLight
                                    : ColorManager.errorRed,
                      ),
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
                      Row(
                        children: [
                          Text(
                              widget.profileData?.firstname ??
                                  widget.profileData?.phone ??
                                  '',
                              style: getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: mob ? 16 : 10)),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(widget.profileData?.lastname ?? '',
                              style: getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: mob ? 16 : 10)),
                        ],
                      ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          widget.profileData?.senderId ==
                                  provider.viewProfileModel?.userdetails?.id
                              ? widget.profileData?.status == "read"
                                  ? const Icon(
                                      Icons.done_all,
                                      color: Colors.blue,
                                      size: 14,
                                    )
                                  : const Icon(
                                      Icons.done_all,
                                      color: ColorManager.black,
                                      size: 14,
                                    )
                              : Container(),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              widget.profileData?.type == 'location'
                                  ? "Location"
                                  : widget.profileData?.type == 'image'
                                      ? "image"
                                      : widget.profileData?.type == 'audio'
                                          ? "Audio"
                                          : widget.profileData?.type ==
                                                  'document'
                                              ? "Document"
                                              : widget.profileData?.message ??
                                                  '',
                              style: getRegularStyle(
                                  color: ColorManager.chatTimeColor,
                                  fontSize: mob ? 11 : 7)),
                        ],
                      ),
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
            top: 10,
            right: lang == 'ar' ? null : 10,
            left: lang == 'ar' ? 10 : null,
            child: Text(widget.time ?? '',
                style: widget.profileData?.unreadCount == 0
                    ? getRegularStyle(
                        color: ColorManager.chatTimeColor,
                        fontSize: mob ? 11 : 8)
                    : getMediumtStyle(
                        color: ColorManager.primary, fontSize: mob ? 11 : 8)),
          ),
          widget.profileData?.unreadCount == 0
              ? Container()
              : Positioned(
                  right: lang == 'ar' ? null : 10,
                  left: lang == 'ar' ? 10 : null,
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 11, backgroundColor: ColorManager.primary,
                        // width: 15,
                        // height: 15,
                        // decoration: BoxDecoration(
                        //     color: ColorManager.primary2,
                        //     borderRadius: BorderRadius.circular(2)),
                        child: Center(
                          child: Text(
                            widget.profileData?.unreadCount.toString() ?? '',
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
