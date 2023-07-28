// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/update_read_status.dart';
import 'package:social_media_services/API/view_chat_messages.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/model/serviceManLIst.dart';
import 'package:social_media_services/model/view_chat_message_model.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/servicer_provider.dart';
import 'package:social_media_services/screens/Google%20Map/share_location_from_app.dart';
import 'package:social_media_services/screens/serviceman/serviceman_list_details.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/utils/get_location.dart';
import 'package:social_media_services/utils/snack_bar.dart';
import 'package:social_media_services/widgets/chat/chat_add_tile.dart';
import 'package:social_media_services/widgets/chat/chat_bubble.dart';
import 'package:social_media_services/widgets/chat/chat_date_widget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:record/record.dart';

class ChatScreen extends StatefulWidget {
  Serviceman? serviceman;
  ChatScreen({super.key, this.serviceman});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool ismicVisible = true;
  bool ismenuVisible = false;
  bool isMapmenuVisible = false;
  bool isDropped = false;
  bool isLocationFetching = false;
  bool isAddressCardSelected = false;
  bool isRecordingOn = false;
  bool isVibrantFeatureAvailable = false;
  bool isScrolling = false;

  List<ChatData>? chatMessages = [];
  final ScrollController _scrollController = ScrollController();

  late Timer timer;
  late Timer Ltimer;
  String lang = '';
  final ImagePicker _picker = ImagePicker();
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  final recorder = Record();

  Future<void> record() async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/myFile.aac';

    await initRecorder();
    await recorder.start(
      path: path,
      encoder: AudioEncoder.aacLc,
    );
  }

  Future stop() async {
    final path = await recorder.stop();
    final file = File(path!);
    List<File> s = [file];
    await uploadAudio(s);
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DataProvider>(context, listen: false);
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    chatMessages = provider.viewChatMessageModel?.chatMessage?.data;
    provider.isSendingSuccessFull = false;
    provider.isLocationSending = false;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      timer = Timer.periodic(const Duration(seconds: 20), (timer) async {
        if (mounted) {
          final servicerProvider =
              Provider.of<ServicerProvider>(context, listen: false);

          await viewChatMessages(
            context,
            servicerProvider.servicerId,
          );
          chatMessages = provider.viewChatMessageModel?.chatMessage?.data;
          updateReadStatus(context, servicerProvider.servicerId);
        }
      });
    });
    _scrollController.addListener(() async {
      setState(() {
        isScrolling = true;
      });
      if (_scrollController.position.atEdge &&
          _scrollController.offset != 0.0) {
        setState(() {
          isScrolling = false;
        });
      }
    });
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    try {
      if (status != PermissionStatus.granted) {
        setState(() {
          isRecordingOn = true;
        });
      } else {
        await Permission.microphone.request();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() async {
    super.dispose();
    recorder.stop();
    timer.cancel();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final w = size.width;
    final provider = Provider.of<DataProvider>(context, listen: true);
    final chatData = provider.viewChatMessageModel?.chatMessage;
    final userAddress = provider.userAddressShow?.userAddress;
    return GestureDetector(
      onTap: () {
        setState(() {
          ismenuVisible = false;
          isMapmenuVisible = false;
          isAddressCardSelected = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
           leading: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.topToBottom,
                          child: ServiceManDetails(
                            serviceman: widget.serviceman,
                          )));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 2),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundImage: provider
                                .serviceManDetails?.userData?.profileImage ==
                            null
                        ? const AssetImage('assets/user.png') as ImageProvider
                        : CachedNetworkImageProvider(
                            '$endPoint${provider.serviceManDetails?.userData?.profileImage}'),
                  ),
                ),
              ),
            ],
          ),
          title: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.topToBottom,
                      child: ServiceManDetails(
                        serviceman: widget.serviceman,
                      )));
            },
            child: Column(
              children: [
                Text(
                  " ${provider.serviceManDetails?.userData?.firstname ?? provider.serviceManDetails?.userData?.phone} ${provider.serviceManDetails?.userData?.lastname ?? ''}",
                  style:
                      getRegularStyle(color: ColorManager.black, fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            // const Icon(Icons.videocam),
            const SizedBox(
              width: 8,
            ),
            InkWell(
                onTap: () {
                  FlutterPhoneDirectCaller.callNumber(
                      provider.serviceManDetails?.userData?.phone ?? '');
                },
                child: const Icon(Icons.call_outlined)),
            const SizedBox(
              width: 20,
            )
          ],
          leadingWidth: 80,
        ),
        body: Stack(
          children: [
            Padding(
                padding:
                    EdgeInsets.fromLTRB(15, 15, 15, isRecordingOn ? 100 : 60),
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: chatData?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final status = chatData?.data?[index].status;

                    final len = chatData?.data?.length;
                    var date = DateFormat("yyyy-MM-dd").parse(
                        chatData?.data?[index].createdAt?.substring(0, 10) ??
                            '',
                        true);
                    String localDate = DateFormat.yMEd().format(date.toLocal());

                    return Column(
                      children: [
                        status != 'waiting'
                            ? Column(
                                children: [
                                  (len! - 1) == index
                                      ? ChatDateWidget(localDate: localDate)
                                      : Container(),
                                  (len - 1) != index &&
                                          chatData?.data?[index].createdAt
                                                  ?.substring(0, 10) !=
                                              chatData
                                                  ?.data?[index + 1].createdAt
                                                  ?.substring(0, 10)
                                      ? ChatDateWidget(localDate: localDate)
                                      : Container(),
                                ],
                              )
                            : Container(),
                        CustomChatBubble(
                          chatMessage: chatData?.data?[index],
                        ),
                      ],
                    );
                  },
                )),

            ismenuVisible
                ? Positioned(
                    bottom: 60,
                    left: lang != 'ar' ? 2 : null,
                    right: lang == 'ar' ? 2 : null,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(5)),
                      width: size.width * .49,
                      height: 155,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 25, bottom: 20, left: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  ismenuVisible = false;
                                });
                                await selectImage();

                                await Future.delayed(
                                    const Duration(seconds: 2));
                                setState(() {});
                              },
                              child: ChatAddTile(
                                  svg: false,
                                  title: lang == 'ar'
                                      ? str.cp_photo2
                                      : "${str.cp_photo1}\n${str.cp_photo2}",
                                  image: ImageAssets.gallery),
                            ),
                            InkWell(
                              onTap: pickDoc,
                              child: ChatAddTile(
                                  svg: false,
                                  title: str.cp_doc,
                                  image: ImageAssets.documents),
                            ),
                            // const SizedBox(
                            //   height: 3,
                            // ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isMapmenuVisible = !isMapmenuVisible;
                                });
                              },
                              child: Container(
                                height: 30,
                                color: isMapmenuVisible
                                    ? ColorManager.selectedGreen
                                    : ColorManager.primary,
                                child: ChatAddTile(
                                  svg: false,
                                  title: str.cp_loc,
                                  image: ImageAssets.map,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                : Container(),
            // * Location Menu

            isMapmenuVisible
                ? Positioned(
                    bottom: 60,
                    left: lang == 'ar' && isAddressCardSelected != true ||
                            lang != 'ar ' && isAddressCardSelected == true
                        ? 2
                        : null,
                    right: lang != 'ar' && isAddressCardSelected != true ||
                            lang == 'ar ' && isAddressCardSelected == true
                        ? 2
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(5)),
                      width: size.width * .49,
                      height: 140,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 14, bottom: 14, left: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                sendingCurrentLocationFunction();
                              },
                              child: ChatAddTile(
                                  svg: true,
                                  title: lang == 'ar'
                                      ? str.cp_s_loc_1
                                      : "${str.cp_s_loc_1}\n${str.cp_s_loc_2}",
                                  image: ImageAssets.currentLocationSvg),
                            ),
                            InkWell(
                              onTap: () {
                                navToSelectLocation();
                              },
                              child: ChatAddTile(
                                  svg: true,
                                  title: str.cp_choose,
                                  image: ImageAssets.chooseFromAppSvg),
                            ),
                            InkWell(
                              onTap: () async {
                                print(userAddress);
                                setState(() {
                                  ismenuVisible = false;
                                  isMapmenuVisible = false;
                                });
                                print(userAddress);

                                if (userAddress!.isEmpty) {
                                  showAnimatedSnackBar(
                                      context, str.snack_no_address);
                                } else {
                                  isAddressCardSelected = true;
                                }
                                // // print(
                                // //     provider.viewProfileModel?.userdetails?.id);
                              },
                              child: ChatAddTile(
                                svg: true,
                                title: str.cp_address,
                                image: ImageAssets.addressCardSvg,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                : Container(),

            // * Is address card selected

            isAddressCardSelected
                ? Positioned(
                    bottom: 60,
                    left: 5,
                    right: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          // color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(5)),
                      width: size.width,
                      // height: 140,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(top: 5, bottom: 5, left: 0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  final userAddressId = provider
                                      .userAddressShow?.userAddress?[index].id
                                      .toString();
                                  // log(userAddressId!);
                                  await sendMessages(
                                      addressId: userAddressId,
                                      addressName:
                                          userAddress?[index].addressName,
                                      'address_card');
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: ColorManager.black,
                                          width: .3)),
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          userAddress?[index].addressName ?? '',
                                          style: getBoldtStyle(
                                              color: ColorManager.whiteColor,
                                              fontSize: 13))
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: userAddress?.length,
                          )),
                    ))
                : Container(),

            // * Message box
            Positioned(
              bottom: 30,right: 5,
              child: Tooltip(

          key: tooltipkey,
          triggerMode: TooltipTriggerMode.manual,
          showDuration: const Duration(seconds: 1),
          message: str.cp_long_press,
          
        ),),
            Positioned(
              bottom: 0,
              child: Container(
                color: ColorManager.whiteColor,
                height: 60,
                width: w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(
                    //   width: mob ? 7 : 2,
                    // ),
                    Material(
                      color: ColorManager.whiteColor,
                      child: InkWell(
                        splashColor: ColorManager.primary,
                        customBorder: const CircleBorder(),
                        onTap: () {
                          setState(() {
                            ismenuVisible = !ismenuVisible;
                          });
                        },
                        child: SizedBox(
                          // width: w * .09,
                          child: Text(
                            String.fromCharCode(Icons.add.codePoint),
                            style: TextStyle(
                              inherit: false,
                              color: ColorManager.primary,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: Icons.add.fontFamily,
                              package: Icons.add.fontPackage,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                        bottom: 10,
                        top: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: ColorManager.primary)),
                        // width: mob ? size.width * 0.69 : size.width * 0.65,
                        width: w * .64,
                        height: 40,
                        child: TextField(
                          controller: msgController,
                          onChanged: (v) {
                            if (v.isNotEmpty) {
                              setState(() {
                                ismicVisible = false;
                              });
                            } else {
                              setState(() {
                                ismicVisible = true;
                              });
                            }
                          },
                          onTap: () {
                            setState(() {
                              ismenuVisible = false;
                              isMapmenuVisible = false;
                            });
                          },
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: w * .02,
                    // ),
                    InkWell(
                      onTap: () async {
                        _onImageButtonPressed(ImageSource.camera, context);
                      },
                      child: const SizedBox(
                        // width: w * .08,
                        child: Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: w * .01,
                    // ),
                    ismicVisible
                        ? InkWell(
                            onLongPress: () async {
                              await record();
                              _stopWatchTimer.onStartTimer();
                              setState(() {
                                isRecordingOn = true;
                              });

                              // Vibration.hasVibrator() != null
                              // isVibrantFeatureAvailable
                              // ?
                              // Vibration.vibrate(duration: 200);
                              // : Vibration.cancel();
                            },
                            onTap: () {
                              Vibration.vibrate(duration: 200);
                              tooltipkey.currentState?.ensureTooltipVisible();
                              // showAnimatedSnackBar(context,str.cp_long_press);
                            },
                            child: SizedBox(
                              width: w * .1,
                              child: const CircleAvatar(
                                backgroundColor: ColorManager.primary,
                                child: Icon(
                                  Icons.mic_none_outlined,
                                  size: 25,
                                  color: ColorManager.whiteColor,
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              await sendMessages('text');

                              // print(servicerProvider.servicerId);
                              // await Future.delayed(
                              //     const Duration(milliseconds: 100));
                              // setState(() {});
                              // await Future.delayed(const Duration(seconds: 1));
                              // setState(() {});
                            },
                            child: SizedBox(
                              width: w * .1,
                              child: const CircleAvatar(
                                backgroundColor: ColorManager.primary,
                                child: Center(
                                  child: Icon(
                                    Icons.send,
                                    size: 25,
                                    color: ColorManager.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),

            // * Recording on container

            isRecordingOn
                ? Positioned(
                    bottom: 0,
                    // top: 20,
                    // right: 0,
                    // right: 0,
                    child: Container(
                      height: 100,
                      width: size.width,
                      color: ColorManager.whiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // const SizedBox(
                          //   width: 15,
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                // width: 50,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    StreamBuilder<int>(
                                      stream: _stopWatchTimer.minuteTime,
                                      initialData:
                                          _stopWatchTimer.minuteTime.value,
                                      builder: (context, snap) {
                                        final value = snap.data;

                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              value.toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Helvetica',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    //* Display every second.
                                    StreamBuilder<int>(
                                      stream: _stopWatchTimer.secondTime,
                                      initialData:
                                          _stopWatchTimer.secondTime.value,
                                      builder: (context, snap) {
                                        final value = snap.data;
                                        final seconds = value! % 60;

                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              ":${seconds.toString()}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    isRecordingOn = false;
                                  });
                                  _stopWatchTimer.onResetTimer();
                                  await recorder.stop();
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: ColorManager.black,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(
                          //   width: 20,
                          // ),

                          // SizedBox(
                          //   width: size.width * .2,
                          // ),

                          Shimmer.fromColors(
                              baseColor: ColorManager.primary,
                              highlightColor: ColorManager.indicatorBorGreen,
                              child: Text(
                                str.cp_re,
                                style: getBoldtStyle(
                                    color: ColorManager.background,
                                    fontSize: 17),
                              )),
                          // SizedBox(
                          //   width: size.width * .2,
                          // ),
                          // const Spacer(),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                isRecordingOn = false;
                              });
                              _stopWatchTimer.onResetTimer();
                              await stop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: SizedBox(
                                width: w * .1,
                                child: const CircleAvatar(
                                  backgroundColor: ColorManager.primary,
                                  child: Center(
                                    child: Icon(
                                      Icons.send,
                                      size: 25,
                                      color: ColorManager.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   width: 5,
                          // )
                        ],
                      ),
                    ))
                : Container(),

            // * is recording on end
            isLocationFetching
                ? Positioned(
                    bottom: 60,
                    child: Container(
                      width: size.width,
                      height: 30,
                      color: ColorManager.whiteColor,
                      child: Center(
                        child: Text(
                          str.fetch_loc,
                        ),
                      ),
                    ))
                : Container(),
            isScrolling
                ? Positioned(
                    left: lang == 'ar' ? 5 : null,
                    right: lang != 'ar' ? 5 : null,
                    bottom: 70,
                    child: InkWell(
                      onTap: () {
                        scrollToBottom();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.black87,
                                spreadRadius: .1)
                          ],
                        ),
                        child: const CircleAvatar(
                            maxRadius: 16,
                            backgroundColor: ColorManager.whiteColor,
                            child: Icon(
                              Icons.keyboard_double_arrow_down_rounded,
                              color: ColorManager.black,
                            )),
                      ),
                    ))
                : Container()
          ],
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(
      ImageSource source, BuildContext context) async {
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      print(pickedFile);
      final list = [pickedFile!];

      await uploadImages(list);
      await viewChatMessages(context, servicerProvider.servicerId);
      final provider = Provider.of<DataProvider>(context, listen: false);
      chatMessages = provider.viewChatMessageModel?.chatMessage?.data;

      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  pickDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // type: FileType.custom,
      allowMultiple: true,
      // allowedExtensions: ['pdf', 'txt', 'wav', 'doc'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      final path = file.path;

      final filePath = File(path!);
      List<File> s = [filePath];
      uploadDocuments(s);

      setState(() {
        // fileName = file.name;
      });
    } else {}
    setState(() {
      ismenuVisible = false;
    });
  }

  sendMessages(String type, {String? addressId, String? addressName}) async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);
    final receiverId = provider.serviceManDetails?.userData?.id.toString();
    final str = AppLocalizations.of(context)!;
    // provider.subServicesModel = null;
    final apiToken = Hive.box("token").get('api_token');
    final datetime = DateTime.now();

    scrollToBottom();

    // * Selecting Url

    String? url;
    if (type == 'text') {
      url =
          '$api/chat-store?receiver_id=$receiverId&type=text&message=${msgController.text}&page=1';
    } else if (type == 'address_card') {
      setState(() {
        isAddressCardSelected = false;
        isMapmenuVisible = false;
      });
      msgController.text = 'Address Card';
      url =
          '$api/chat-store?receiver_id=$receiverId&type=address_card&message=${str.cp_address} : $addressName&page=1&address_id=$addressId';
    }

    ChatData waitingMessage = ChatData(
        message: msgController.text,
        type: type,
        status: 'waiting',
        createdAt: '2022-12-23T05:03:41.000000Z',
        localTime: datetime.toString(),
        senderId: provider.viewProfileModel?.userdetails?.id,
        addressId: null);
    chatMessages?.insert(0, waitingMessage);
    setState(() {});
    // print(chatMessages?[0].toJson());
    // return;

    final text = msgController.text;
    msgController.text = '';
    setState(() {
      ismicVisible = true;
    });

    if (apiToken == null) return;
    try {
      var response = await http.post(Uri.parse(url ?? ''), headers: {
        "device-id": provider.deviceId ?? '',
        "api-token": apiToken
      });
      if (response.statusCode == 200) {
        await viewChatMessages(context, servicerProvider.servicerId);
        setState(() {
          chatMessages?.clear();
        });
        chatMessages = provider.viewChatMessageModel?.chatMessage?.data;

        setState(() {});
      } else {
        msgController.text = text;
        setState(() {
          ismicVisible = false;
        });
        showAnimatedSnackBar(context, str.snack_message_sent);
      }
    } on Exception catch (_) {
      showAnimatedSnackBar(context, str.snack_message_sent);

      setState(() {
        ismicVisible = false;
      });
      msgController.text = text;
    }
  }

// * Select Image Function

  selectImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images == null) {
      return;
    }

    uploadImages(images);
  }

  uploadImages(List<XFile> imageFile) async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final userData = provider.serviceManProfile?.userData;
    final receiverId = provider.serviceManDetails?.userData?.id.toString();
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);
    provider.sendImage = imageFile[0];

    final length = imageFile.length;
    var uri =
        Uri.parse('$api/chat-store?receiver_id=$receiverId&type=image&page=1');
    final datetime = DateTime.now();

    ChatData waitingMessage = ChatData(
        message: msgController.text,
        type: 'image',
        status: 'waiting',
        createdAt: '2022-12-23T05:03:41.000000Z',
        localTime: datetime.toString(),
        senderId: provider.viewProfileModel?.userdetails?.id,
        // sendUserId: 42,
        // firstname: 'sergio',
        // onlineStatus: 'busy',
        // chatMedia: '/assets/uploads/chatmedia/',
        // profileImage: '/assets/uploads/profile/profile_1669789172.jpg',
        addressId: null);
    chatMessages?.insert(0, waitingMessage);
    setState(() {});
    // return;
    var request = http.MultipartRequest(
      "POST",
      uri,
    );

    print(uri);

    List<MultipartFile> multiPart = [];
    for (var i = 0; i < length; i++) {
      var stream = http.ByteStream(DelegatingStream(imageFile[i].openRead()));
      var length = await imageFile[i].length();
      final apiToken = Hive.box("token").get('api_token');

      request.headers.addAll(
          {"device-id": provider.deviceId ?? '', "api-token": apiToken});
      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: (imageFile[i].path),
      );
      multiPart.add(multipartFile);
    }

    length > 1
        ? request.files.addAll(multiPart)
        : request.files.add(multiPart[0]);

    // "content-type": "multipart/form-data"

    var response = await request.send();
    final res = await http.Response.fromStream(response);
    var jsonResponse = jsonDecode(res.body);
    await viewChatMessages(context, servicerProvider.servicerId);

    if (jsonResponse["result"] == false) {
      showAnimatedSnackBar(context, jsonResponse["message"]);
      setState(() {});
      return;
    }
  }

  // * Upload audio

  uploadAudio(List<File> imageFile) async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);

    final receiverId = provider.serviceManDetails?.userData?.id.toString();
    final str = AppLocalizations.of(context)!;
    final length = imageFile.length;
    final datetime = DateTime.now();
    ChatData waitingMessage = ChatData(
        message: msgController.text,
        type: 'audio',
        status: 'waiting',
        createdAt: '2022-12-23T05:03:41.000000Z',
        localTime: datetime.toString(),
        senderId: provider.viewProfileModel?.userdetails?.id,
        addressId: null);
    chatMessages?.insert(0, waitingMessage);
    setState(() {});
    // return;
    try {
      var uri = Uri.parse(
          '$api/chat-store?receiver_id=$receiverId&type=audio&page=1');
      var request = http.MultipartRequest(
        "POST",
        uri,
      );

      List<MultipartFile> multiPart = [];
      for (var i = 0; i < length; i++) {
        var stream = http.ByteStream(DelegatingStream(imageFile[i].openRead()));
        var length = await imageFile[i].length();
        final apiToken = Hive.box("token").get('api_token');

        request.headers.addAll(
            {"device-id": provider.deviceId ?? '', "api-token": apiToken});
        var multipartFile = http.MultipartFile(
          'file',
          stream,
          length,
          filename: (imageFile[i].path),
        );
        multiPart.add(multipartFile);
      }

      length > 1
          ? request.files.addAll(multiPart)
          : request.files.add(multiPart[0]);

      var response = await request.send();

      final res = await http.Response.fromStream(response);
      var jsonResponse = jsonDecode(res.body);
      // print(jsonResponse);
      if (jsonResponse["result"] == false) {
        showAnimatedSnackBar(context, str.snack_message_sent);
        setState(() {});
        return;
      }
      await viewChatMessages(context, servicerProvider.servicerId);
      // chatMessages?.remove(0);
      chatMessages = provider.viewChatMessageModel?.chatMessage?.data;
      Future.delayed(const Duration(seconds: 2));
      setState(() {});
    } catch (e) {
      showAnimatedSnackBar(context, str.snack_message_sent);
    }
  }

  uploadDocuments(List<File> imageFile) async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);
    final receiverId = provider.serviceManDetails?.userData?.id.toString();
    final length = imageFile.length;
    final str = AppLocalizations.of(context)!;
    final datetime = DateTime.now();

    ChatData waitingMessage = ChatData(
        message: msgController.text,
        type: 'document',
        status: 'waiting',
        createdAt: '2022-12-23T05:03:41.000000Z',
        localTime: datetime.toString(),
        senderId: provider.viewProfileModel?.userdetails?.id,
        addressId: null);
    chatMessages?.insert(0, waitingMessage);
    setState(() {});
    try {
      var uri = Uri.parse(
          '$api/chat-store?receiver_id=$receiverId&type=document&page=1');
      var request = http.MultipartRequest(
        "POST",
        uri,
      );

      List<MultipartFile> multiPart = [];
      for (var i = 0; i < length; i++) {
        var stream = http.ByteStream(DelegatingStream(imageFile[i].openRead()));
        var length = await imageFile[i].length();
        final apiToken = Hive.box("token").get('api_token');

        request.headers.addAll(
            {"device-id": provider.deviceId ?? '', "api-token": apiToken});
        var multipartFile = http.MultipartFile(
          'file',
          stream,
          length,
          filename: (imageFile[i].path),
        );
        multiPart.add(multipartFile);
      }

      length > 1
          ? request.files.addAll(multiPart)
          : request.files.add(multiPart[0]);

      var response = await request.send();

      final res = await http.Response.fromStream(response);
      var jsonResponse = jsonDecode(res.body);
      // print(jsonResponse);
      if (jsonResponse["result"] == false) {
        showAnimatedSnackBar(context, str.snack_message_sent);
        setState(() {});
        return;
      }
      await viewChatMessages(context, servicerProvider.servicerId);
      chatMessages = provider.viewChatMessageModel?.chatMessage?.data;
      Future.delayed(const Duration(seconds: 2));
      setState(() {});
    } catch (e) {
      showAnimatedSnackBar(context, str.snack_message_sent);
    }
  }

  sendingCurrentLocationFunction() async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);
    setState(() {
      isMapmenuVisible = false;
      ismenuVisible = false;
    });
    // setState(() {
    //   isLocationFetching = true;
    // });
    final datetime = DateTime.now();

    ChatData waitingMessage = ChatData(
        message: msgController.text,
        type: 'location',
        status: 'waiting',
        createdAt: '2022-12-23T05:03:41.000000Z',
        localTime: datetime.toString(),
        senderId: provider.viewProfileModel?.userdetails?.id,
        addressId: null);
    chatMessages?.insert(0, waitingMessage);
    setState(() {});

    // return;
    await sendCurrentLocation(context);
    await viewChatMessages(context, servicerProvider.servicerId);
    chatMessages = provider.viewChatMessageModel?.chatMessage?.data;
    provider.isLocationSending = false;
    provider.isSendingSuccessFull = false;

    // setState(() {
    //   isLocationFetching = false;
    // });
  }

  navToSelectLocation() async {
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);
    setState(() {
      isMapmenuVisible = false;
      ismenuVisible = false;
    });

    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return const SelectLocationFromApp();
    }));
    Ltimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final provider = Provider.of<DataProvider>(context, listen: false);
      if (provider.isLocationSending) {
        log("Loading started");
        FocusManager.instance.primaryFocus?.unfocus();
        final datetime = DateTime.now();

        ChatData waitingMessage = ChatData(
            message: msgController.text,
            type: 'location',
            status: 'waiting',
            createdAt: '2022-12-23T05:03:41.000000Z',
            localTime: datetime.toString(),
            senderId: provider.viewProfileModel?.userdetails?.id,
            addressId: null);
        chatMessages?.insert(0, waitingMessage);
        setState(() {});

        if (provider.isSendingSuccessFull) {
          log("Location sended successfully get");
          provider.isLocationSending = false;
          provider.isSendingSuccessFull = false;
          print(provider.isLocationSending);
          await viewChatMessages(context, servicerProvider.servicerId);
          chatMessages = provider.viewChatMessageModel?.chatMessage?.data;
          Ltimer.cancel();
          setState(() {});
        } else {
          Ltimer.cancel();
        }

        // return;
      }
    });
  }

  scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
}
