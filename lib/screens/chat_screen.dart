import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/camera_screen.dart';
import 'package:social_media_services/utils/snack_bar.dart';
import 'package:social_media_services/widgets/chat_add_tile.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibration/vibration.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _isHours = true;
  bool ismicVisible = true;
  bool ismenuVisible = false;
  bool isMapmenuVisible = false;
  bool isDropped = false;
  // bool isAnimationVisible = false;
  bool isRecordingOn = false;
  bool isVibrantFeatureAvailable = false;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStopped: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  @override
  void initState() {
    super.initState();
    initfun();
    // isVib();
    // setState(() {
    //   isVibrantFeatureAvailable = isVib();
    // });

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _stopWatchTimer.onStartTimer;

    final size = MediaQuery.of(context).size;
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
              // backgroundColor: ColorManager.grayLight.withOpacity(0.8),
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
            Positioned(
                top: 0,
                // left: 30,
                child: Column(
                  children: const [],
                )),
            ismenuVisible
                ? Positioned(
                    bottom: 60,
                    left: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(5)),
                      width: size.width * .435,
                      height: 150,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, bottom: 20, left: 0),
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
                    right: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(5)),
                      width: size.width * .53,
                      height: 130,
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
                    const SizedBox(
                      width: 10,
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
                      padding: const EdgeInsets.only(left: 5.0, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: ColorManager.primary)),
                        width: size.width * 0.69,
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
                      width: 5,
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
                    const SizedBox(
                      width: 5,
                    ),
                    ismicVisible
                        ? InkWell(
                            onTap: () {
                              print("object");
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
                      width: 25,
                    ),
                  ],
                ),
              ),
            ),
            ismicVisible
                ? Positioned(
                    bottom: 16,
                    right: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          // border: isAnimationVisible
                          //     ? Border.all(
                          //         color: ColorManager.grayLight,
                          //       )
                          //     : Border.all(color: ColorManager.whiteColor),
                          borderRadius: BorderRadius.circular(10)),
                      height:
                          //  isAnimationVisible ? 125 :
                          35,
                      width: 35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // isAnimationVisible
                          //     ? DragTarget<String>(
                          //         builder: (
                          //           BuildContext context,
                          //           List<dynamic> accepted,
                          //           List<dynamic> rejected,
                          //         ) {
                          //           return SizedBox(
                          //               height: 90,
                          //               width: 35,
                          //               // color: Colors.yellow,
                          //               child: Column(
                          //                 children: [
                          //                   isDropped
                          //                       ? const Icon(Icons.lock)
                          //                       : const Icon(
                          //                           Icons.lock_open,
                          //                         )
                          //                 ],
                          //               ));
                          //         },
                          //         onWillAccept: (data) {
                          //           return data == 'red';
                          //         },
                          //         onAccept: (data) {
                          //           setState(() {
                          //             isDropped = true;
                          //           });
                          //         },
                          //       )
                          //     : Container(),
                          // isAnimationVisible
                          //     ? const SizedBox(
                          //         height: 0,
                          //       )
                          //     : Container(),
                          Draggable<String>(
                            // Data is the value this Draggable stores.
                            // onDragStarted: () {
                            //   setState(() {
                            //     isAnimationVisible = true;
                            //   });
                            // },
                            data: 'red',
                            feedback: const Icon(
                              Icons.mic_none_outlined,
                              size: 30,
                              color: ColorManager.primary,
                            ),
                            // * background item
                            axis: Axis.vertical,
                            childWhenDragging: const Icon(
                              Icons.mic_rounded,
                              size: 30,
                              color: ColorManager.grayLight,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Vibration.vibrate(duration: 200);
                                showSnackBar("Long press to record", context);
                              },
                              // onTap: () async {
                              //   // initfun();
                              //   _stopWatchTimer.onStartTimer;
                              //   print('object');
                              //   // await Vibration.hasVibrator() != null
                              //   //     ? Vibration.vibrate(duration: 200)
                              //   //     : Vibration.cancel();
                              //   showSnackBar("Long press to record", context);
                              // },
                              // onLongPress: () {
                              //   // initfun();
                              //   _stopWatchTimer.onStartTimer;
                              //   // await Vibration.hasVibrator() != null
                              //   //     ? Vibration.vibrate(duration: 200)
                              //   //     : Vibration.cancel();
                              //   // setState(() {
                              //   //   // isAnimationVisible = true;
                              //   // });
                              //   // await initfun();
                              // },
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
                              child: const Icon(
                                Icons.mic_none_outlined,
                                size: 30,
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),

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

  initfun() {
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    _stopWatchTimer.fetchStopped
        .listen((value) => print('stopped from stream'));
    _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));
  }
}

bool isVib() {
  final vib = Vibration.hasVibrator() != null ? true : false;
  return vib;
}
