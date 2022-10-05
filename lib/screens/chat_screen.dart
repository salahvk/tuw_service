import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/custom/links.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/screens/camera_screen.dart';
import 'package:social_media_services/utils/snack_bar.dart';
import 'package:social_media_services/widgets/chat_add_tile.dart';
import 'package:social_media_services/widgets/chat_bubble.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibration/vibration.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool ismicVisible = true;
  bool ismenuVisible = false;
  bool isMapmenuVisible = false;
  bool isDropped = false;

  // bool isAnimationVisible = false;
  bool isRecordingOn = false;
  bool isVibrantFeatureAvailable = false;
  String lang = '';

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );

    // isVib();
    // setState(() {
    //   isVibrantFeatureAvailable = isVib();
    // });
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool mob = Responsive.isMobile(context);
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
            child: CircleAvatar(
              radius: 14,
              child: CircleAvatar(
                radius: 16,
                child: Image.asset(
                  ImageAssets.profileIcon,
                ),
              ),
            ),
          ),
          title: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.workerDetails);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Akhil Mahesh',
                  style:
                      getRegularStyle(color: ColorManager.black, fontSize: 16),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImageAssets.tools),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("Engin Worker",
                        style: getRegularStyle(
                            color: const Color.fromARGB(255, 173, 173, 173),
                            fontSize: 15))
                  ],
                ),
              ],
            ),
          ),
          actions: const [
            Icon(Icons.videocam),
            SizedBox(
              width: 8,
            ),
            Icon(Icons.call_outlined),
            SizedBox(
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
                children: [
                  CustomChatBubble(
                      isSendByme: true,
                      seen: true,
                      text: 'How can help you',
                      image: "",
                      time: "2:05 PM"),
                  CustomChatBubble(
                    isSendByme: false,
                    seen: false,
                    time: "3:00 PM",
                    image: switzeland,
                    text: 'Hi friend',
                  ),
                  CustomChatBubble(
                    isSendByme: true,
                    seen: false,
                    time: "5:00 PM",
                    image: '',
                    text: 'Where are you now',
                  ),
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
                            const ChatAddTile(
                                title: "Photo & Video\nLibrary",
                                image: ImageAssets.gallery),
                            const ChatAddTile(
                                title: "Documents",
                                image: ImageAssets.documents),
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
                                child: const ChatAddTile(
                                  title: "Share Location",
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
                            const ChatAddTile(
                                title: "Send Current\nLocation",
                                image: ImageAssets.currentLocation),
                            const ChatAddTile(
                                title: "Choose From App",
                                image: ImageAssets.chooseFromApp),
                            InkWell(
                              onTap: () {},
                              child: const ChatAddTile(
                                title: "Address Card",
                                image: ImageAssets.addressCard,
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
                      onTap: () async {
                        print('Icon pressed');
                        late List<CameraDescription> cameras;
                        cameras = await availableCameras();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return CameraApp(
                            cameras: cameras,
                          );
                        }));
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: ColorManager.primary,
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
                            onTap: () {
                              Vibration.vibrate(duration: 200);
                              showSnackBar("Long press to record", context);
                            },
                            child: const Icon(
                              Icons.mic_none_outlined,
                              size: 30,
                              color: ColorManager.primary,
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
            // ismicVisible
            //     ? Positioned(
            //         // top: 0,
            //         bottom: 16,
            //         right: lang != 'ar' ? 4 : null,
            //         left: lang == 'ar' ? 4 : null,
            //         child: Container(
            //           decoration: BoxDecoration(
            //               color: ColorManager.whiteColor,
            //               // border: isAnimationVisible
            //               //     ? Border.all(
            //               //         color: ColorManager.grayLight,
            //               //       )
            //               //     : Border.all(color: ColorManager.whiteColor),
            //               borderRadius: BorderRadius.circular(10)),
            //           height:
            //               //  isAnimationVisible ? 125 :
            //               35,
            //           width: 35,
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               // isAnimationVisible
            //               //     ? DragTarget<String>(
            //               //         builder: (
            //               //           BuildContext context,
            //               //           List<dynamic> accepted,
            //               //           List<dynamic> rejected,
            //               //         ) {
            //               //           return SizedBox(
            //               //               height: 90,
            //               //               width: 35,
            //               //               // color: Colors.yellow,
            //               //               child: Column(
            //               //                 children: [
            //               //                   isDropped
            //               //                       ? const Icon(Icons.lock)
            //               //                       : const Icon(
            //               //                           Icons.lock_open,
            //               //                         )
            //               //                 ],
            //               //               ));
            //               //         },
            //               //         onWillAccept: (data) {
            //               //           return data == 'red';
            //               //         },
            //               //         onAccept: (data) {
            //               //           setState(() {
            //               //             isDropped = true;
            //               //           });
            //               //         },
            //               //       )
            //               //     : Container(),
            //               // isAnimationVisible
            //               //     ? const SizedBox(
            //               //         height: 0,
            //               //       )
            //               //     : Container(),
            //               Draggable<String>(
            //                 // Data is the value this Draggable stores.
            //                 // onDragStarted: () {
            //                 //   setState(() {
            //                 //     isAnimationVisible = true;
            //                 //   });
            //                 // },
            //                 data: 'red',
            //                 feedback: const Icon(
            //                   Icons.mic_none_outlined,
            //                   size: 30,
            //                   color: ColorManager.primary,
            //                 ),
            //                 // * background item
            //                 axis: Axis.vertical,
            //                 childWhenDragging: const Icon(
            //                   Icons.mic_rounded,
            //                   size: 30,
            //                   color: ColorManager.grayLight,
            //                 ),
            //                 child: GestureDetector(
            //                   onTap: () {
            //                     Vibration.vibrate(duration: 200);
            //                     showSnackBar("Long press to record", context);
            //                   },
            //                   // onTap: () async {
            //                   //   // initfun();
            //                   //   _stopWatchTimer.onStartTimer;

            //                   //   // await Vibration.hasVibrator() != null
            //                   //   //     ? Vibration.vibrate(duration: 200)
            //                   //   //     : Vibration.cancel();
            //                   //   showSnackBar("Long press to record", context);
            //                   // },
            //                   // onLongPress: () {
            //                   //   // initfun();
            //                   //   _stopWatchTimer.onStartTimer;
            //                   //   // await Vibration.hasVibrator() != null
            //                   //   //     ? Vibration.vibrate(duration: 200)
            //                   //   //     : Vibration.cancel();
            //                   //   // setState(() {
            //                   //   //   // isAnimationVisible = true;
            //                   //   // });
            //                   //   // await initfun();
            //                   // },
            //                   onLongPress: () {
            //                     _stopWatchTimer.onStartTimer();
            //                     setState(() {
            //                       isRecordingOn = true;
            //                     });
            //                     // Vibration.hasVibrator() != null
            //                     // isVibrantFeatureAvailable
            //                     // ?
            //                     Vibration.vibrate(duration: 200);
            //                     // : Vibration.cancel();
            //                   },
            //                   child: const Icon(
            //                     Icons.mic_none_outlined,
            //                     size: 30,
            //                     color: ColorManager.primary,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            //     : Container(),

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
                                      print('Listen every minute. $value');
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
                                      print('Listen every second. $value');
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
                                  "Recording",
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
}

bool isVib() {
  final vib = Vibration.hasVibrator() != null ? true : false;
  return vib;
}
