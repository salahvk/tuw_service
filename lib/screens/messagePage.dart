import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/get_chat_list.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/loading%20screens/chat_loading_screen.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/servicer_provider.dart';
import 'package:social_media_services/responsive/responsive_width.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/widgets/chat/chat_list_tile.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessagePage extends StatefulWidget {
  final bool isHome;
  const MessagePage({Key? key, this.isHome = true}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String lang = '';
  late Timer timer;
  String? time;
  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getChatList(
        context,
      );
      timer = Timer.periodic(const Duration(seconds: 30), (timer) {
        if (mounted) {
          getChatList(
            context,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    log("Dispose");
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
      return const HomePage(
        selectedIndex: 0,
      );
    }));
    return true; // return true if the route to be popped
  }

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<DataProvider>(context, listen: true);
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: true);
    final w = MediaQuery.of(context).size.width;
    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);
    final str = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async {
        return _willPopCallback();
      },
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        endDrawer: SizedBox(
          height: size.height * 0.825,
          width: mobWth
              ? size.width * 0.6
              : smobWth
                  ? w * .7
                  : w * .75,
          child: const CustomDrawer(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        str.mh_message,
                        style: getBoldtStyle(
                            color: ColorManager.black, fontSize: 20),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Text(
                    str.mh_recents,
                    style: getSemiBoldtStyle(
                        color: ColorManager.black, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount:
                          provider.chatListDetails?.chatMessage?.data?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final profileDetails =
                            provider.chatListDetails?.chatMessage?.data?[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(4, 4.5),
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        navToChatLoadingScreen(index);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: ColorManager.whiteColor
                                            .withOpacity(0.8),
                                        radius: 25,
                                        backgroundImage: profileDetails
                                                    ?.profilePic ==
                                                null
                                            ? const AssetImage(
                                                    'assets/user.png')
                                                as ImageProvider
                                            : CachedNetworkImageProvider(
                                                '$endPoint${profileDetails?.profilePic}'),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    left: 1,
                                    // left: size.width * .0,
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor:
                                          profileDetails?.onlineStatus ==
                                                  'online'
                                              ? ColorManager.primary
                                              : profileDetails?.onlineStatus ==
                                                      'offline'
                                                  ? ColorManager.grayLight
                                                  : ColorManager.errorRed,
                                    ),
                                  )
                                ],
                              ),
                              Text(profileDetails?.firstname ??
                                  profileDetails?.phone ??
                                  ''),
                            ],
                          ),
                        );
                      }),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    final profileDetails =
                        provider.chatListDetails?.chatMessage?.data?[index];

                    var dtime = DateFormat("HH:mm").parse(
                        profileDetails?.createdAt?.substring(11, 16) ?? '',
                        true);

                    var date = DateFormat("yyyy-MM-dd").parse(
                        profileDetails?.createdAt?.substring(0, 10) ?? '',
                        true);
                    String localDate =
                        DateFormat.yMd('es').format(date.toLocal());

                    var hour = dtime.toLocal().hour;
                    var minute = dtime.toLocal().minute;

                    var day = date.toLocal().weekday;
                    if (DateTime.now().weekday == day) {
                      String time24 = "$hour:$minute";
                      time = DateFormat.jm()
                          .format(DateFormat("hh:mm").parse(time24));
                    } else if (day == DateTime.now().weekday - 1) {
                      time = "Yesterday";
                    } else {
                      time = localDate;
                    }

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: InkWell(
                        onTap: () {
                          navToChatLoadingScreen(index);
                        },
                        child: ChatListTile(
                          profileData: profileDetails,
                          time: time,
                        ),
                      ),
                    );
                  }),
                  itemCount:
                      provider.chatListDetails?.chatMessage?.data?.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  navToChatLoadingScreen(index) {
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);
    final provider = Provider.of<DataProvider>(context, listen: false);
    final serviceManId =
        provider.chatListDetails?.chatMessage?.data?[index].servicemanId;
    servicerProvider.servicerId = serviceManId;
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return ChatLoadingScreen(
        serviceManId: serviceManId.toString(),
      );
    }));
  }
}
