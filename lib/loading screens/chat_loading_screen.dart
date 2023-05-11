// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_services/API/get_chat_list.dart';
import 'package:social_media_services/API/get_serviceManProfileDetails.dart';
import 'package:social_media_services/API/other%20User/other_user_address_list.dart';
import 'package:social_media_services/API/update_read_status.dart';
import 'package:social_media_services/API/view_chat_messages.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';

import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/screens/chat_screen.dart';
import 'package:social_media_services/widgets/chat/chat_add_tile.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';

class ChatLoadingScreen extends StatefulWidget {
  String? serviceManId;
  ChatLoadingScreen({super.key, this.serviceManId});

  @override
  State<ChatLoadingScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatLoadingScreen> {
  bool ismicVisible = true;
  bool ismenuVisible = false;
  bool isMapmenuVisible = false;
  bool isDropped = false;
  bool isRecordingOn = false;
  bool isVibrantFeatureAvailable = false;
  String lang = '';
  VideoPlayerController? _controller;

  final ImagePicker _picker = ImagePicker();

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<DataProvider>(context, listen: false);
      await getServiceManDetailsFun(context, widget.serviceManId);
      await viewChatMessages(context, widget.serviceManId);
      print("Roooo");
      await getOtherUserAddress(context, widget.serviceManId ?? '');
      print("Roooo");
      if (provider.otherUserAddress?.userAddress == null) {
        Navigator.pop(context);
        return;
      }
      await updateReadStatus(context, widget.serviceManId);
      getChatList(
        context,
      );
      Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ChatScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool mob = Responsive.isMobile(context);
    final str = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        setState(() {
          ismenuVisible = false;
          isMapmenuVisible = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Shimmer.fromColors(
              baseColor: ColorManager.whiteColor,
              highlightColor: Colors.green,
              child: const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('assets/user.png'),
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: ColorManager.whiteColor,
                highlightColor: Colors.green,
                child: Text(
                  'Daniel',
                  style:
                      getRegularStyle(color: ColorManager.black, fontSize: 16),
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(ImageAssets.tools),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  Text('',
                      style: getRegularStyle(
                          color: const Color.fromARGB(255, 173, 173, 173),
                          fontSize: 15))
                ],
              ),
            ],
          ),
          actions: [
            // const Icon(Icons.videocam),
            const SizedBox(
              width: 8,
            ),
            Shimmer.fromColors(
                baseColor: ColorManager.whiteColor,
                highlightColor: Colors.green,
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
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                children: const [
                  // Shimmer.fromColors(
                  //   baseColor: ColorManager.whiteColor,
                  //   highlightColor: Colors.green,
                  //   child: Container(
                  //     width: size.width * .5,
                  //     height: 50,
                  //     color: ColorManager.whiteColor,
                  //   ),
                  // ),
                  // Shimmer.fromColors(
                  //   baseColor: ColorManager.whiteColor,
                  //   highlightColor: Colors.green,
                  //   child: Container(
                  //     width: size.width * .5,
                  //     height: 50,
                  //     color: ColorManager.whiteColor,
                  //   ),
                  // ),
                  // Shimmer.fromColors(
                  //   baseColor: ColorManager.whiteColor,
                  //   highlightColor: Colors.green,
                  //   child: Container(
                  //     width: size.width * .5,
                  //     height: 50,
                  //     color: ColorManager.whiteColor,
                  //   ),
                  // ),
                ],
              ),
            ),

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
                              onTap: pickGallery,
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
                    left: lang == 'ar' ? 2 : null,
                    right: lang != 'ar' ? 2 : null,
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
                            ChatAddTile(
                                svg: true,
                                title: lang == 'ar'
                                    ? str.cp_s_loc_1
                                    : "${str.cp_s_loc_1}\n${str.cp_s_loc_2}",
                                image: ImageAssets.currentLocationSvg),
                            ChatAddTile(
                                svg: true,
                                title: str.cp_choose,
                                image: ImageAssets.chooseFromAppSvg),
                            InkWell(
                              onTap: () {},
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
            Positioned(
              bottom: 0,
              // left: 0,
              // right: 0,
              child: Container(
                color: ColorManager.whiteColor,
                height: 60,
                child: Row(
                  children: [
                    SizedBox(
                      width: mob ? 7 : 2,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          ismenuVisible = !ismenuVisible;
                        });
                      },
                      child: Shimmer.fromColors(
                        baseColor: ColorManager.whiteColor,
                        highlightColor: Colors.green,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: ColorManager.primary)),
                        width: mob ? size.width * 0.69 : size.width * 0.65,
                        height: 40,
                        child: TextField(
                          // controller: chatMsg,
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
                    const SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      child: Shimmer.fromColors(
                        baseColor: ColorManager.whiteColor,
                        highlightColor: Colors.green,
                        child: const Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: mob ? 5 : 2,
                    ),
                    ismicVisible
                        ? InkWell(
                            onLongPress: () {
                              _stopWatchTimer.onStartTimer();
                              setState(() {
                                isRecordingOn = true;
                              });
                              // Vibration.hasVibrator() != null
                              // isVibrantFeatureAvailable
                              // ?
                              Vibration.vibrate(duration: 200);
                              // : Vibration.cancel();
                            },
                            child: Shimmer.fromColors(
                              baseColor: ColorManager.whiteColor,
                              highlightColor: Colors.green,
                              child: const Icon(
                                Icons.mic_none_outlined,
                                size: 30,
                                color: ColorManager.primary,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.send,
                            size: 30,
                            color: ColorManager.primary,
                          ),
                    const SizedBox(
                      width: 35,
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
                      height: 60,
                      width: size.width,
                      color: ColorManager.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const Icon(
                              Icons.delete,
                              color: ColorManager.black,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 50,
                              child: Row(
                                children: [
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
                            SizedBox(
                              width: size.width * .2,
                            ),

                            Shimmer.fromColors(
                                baseColor: ColorManager.primary,
                                highlightColor: ColorManager.indicatorBorGreen,
                                child: Text(
                                  str.cp_re,
                                  style: getBoldtStyle(
                                      color: ColorManager.background,
                                      fontSize: 17),
                                )),
                            SizedBox(
                              width: size.width * .2,
                            ),
                            // const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isRecordingOn = false;
                                });
                                _stopWatchTimer.onResetTimer();
                              },
                              child: const Icon(
                                Icons.send,
                                size: 30,
                                color: ColorManager.primary,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ),
                    ))
                : Container()
          ],
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    // if (isVideo) {
    //   final XFile? file = await _picker.pickVideo(
    //       source: source, maxDuration: const Duration(seconds: 10));
    //   await _playVideo(file);
    // } else
    //  if (isMultiImage) {
    //   await _displayPickImageDialog(context!,
    //       (double? maxWidth, double? maxHeight, int? quality) async {
    //     try {
    //       final List<XFile> pickedFileList = await _picker.pickMultiImage(
    //         maxWidth: maxWidth,
    //         maxHeight: maxHeight,
    //         imageQuality: quality,
    //       );
    //       setState(() {
    //         _imageFileList = pickedFileList;
    //       });
    //     } catch (e) {
    //       setState(() {
    //         _pickImageError = e;
    //       });
    //     }
    //   });
    // }
    // if {
    // await _displayPickImageDialog(context!,
    //     (double? maxWidth, double? maxHeight, int? quality) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        // maxWidth: maxWidth,
        // maxHeight: maxHeight,
        // imageQuality: quality,
      );
      setState(() {
        // _setImageFileListFromFile(pickedFile);
      });
    } catch (e) {
      setState(() {
        // _pickImageError = e;
      });
    }
    // });
    // }
  }

  pickGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'mp4', 'png'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        // fileName = file.name;
      });
    } else {}
    setState(() {
      ismenuVisible = false;
    });
  }

  pickDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['pdf', 'txt'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        // fileName = file.name;
      });
    } else {}
    setState(() {
      ismenuVisible = false;
    });
  }
}
