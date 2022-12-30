import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'dart:math' as math;

class VoiceWidget extends StatefulWidget {
  final String path;
  final String time;
  final bool isSendByme;
  final bool seen;
  const VoiceWidget({
    required this.path,
    required this.time,
    required this.seen,
    required this.isSendByme,
  });
  @override
  _VoiceWidgetState createState() => _VoiceWidgetState();
}

class _VoiceWidgetState extends State<VoiceWidget> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  AudioPlayer? audioPlayer;
  bool voice = false;
  String lang = '';

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer?.seek(newDuration);
  }

  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    log("Voice Widget init Calling");
    audioPlayer = AudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted) {
        audioPlayer?.onDurationChanged.listen((d) {
          setState(() {
            _duration = d;
          });
        });
        audioPlayer?.onPositionChanged.listen((p) {
          setState(() {
            _position = p;
          });
        });
        audioPlayer?.onPlayerComplete.listen((p) {
          setState(() {
            _position = _duration;
            voice = !voice;
          });
        });
        audioPlayer?.setSourceUrl(widget.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .66,
      height: size.height * .07,
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                voice
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            voice = !voice;
                          });
                          audioPlayer?.pause();
                        },
                        child: SizedBox(
                            width: size.width * .08,
                            // padding: EdgeInsets.only(bottom: size.height * .1),
                            child: Icon(
                              Icons.pause,
                              color: ColorManager.indicatorBorGreen,
                              size: size.height * .05,
                            )))
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            voice = !voice;
                          });
                          audioPlayer?.play(UrlSource(widget.path));
                        },
                        child: SizedBox(
                          width: size.width * .08,
                          child: Container(
                              // padding: EdgeInsets.only(bottom: size.height * .01),
                              child: Transform.rotate(
                            angle: lang == 'ar' ? 180 * math.pi / 180 : 0,
                            child: Icon(
                              Icons.play_arrow_sharp,
                              color: ColorManager.indicatorBorGreen,
                              size: size.height * .05,
                            ),
                          )),
                        )),
                SizedBox(
                  height: 15,
                  width: size.width * .58,
                  child: Slider(
                    activeColor: ColorManager.primary3,
                    inactiveColor: ColorManager.primary,
                    value: _position.inSeconds.toDouble(),
                    min: 0.0,
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        changeToSecond(value.toInt());
                        value = value;
                      });
                    },
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SizedBox(
                //       height: 15,
                //       // width: size.width * .6,
                //       child: Slider(
                //         activeColor: ColorManager.errorRed,
                //         inactiveColor: ColorManager.primary,
                //         value: _position.inSeconds.toDouble(),
                //         min: 0.0,
                //         max: _duration.inSeconds.toDouble(),
                //         onChanged: (value) {
                //           setState(() {
                //             changeToSecond(value.toInt());
                //             value = value;
                //           });
                //         },
                //       ),
                //     ),
                //     Row(
                //       children: [
                //         Container(
                //           margin: EdgeInsets.only(left: size.width / 15),
                //           child: Text(
                //             _position.toString().split(".")[0],
                //             style: const TextStyle(fontSize: 10),
                //           ),
                //         ),
                //         SizedBox(
                //           width: size.width / 4.5,
                //         ),
                //         Container(
                //           child: Text(
                //             _duration.toString().split(".")[0],
                //             style: const TextStyle(fontSize: 10),
                //           ),
                //           // durationList[index].toString().split(".")[0]
                //         )
                //       ],
                //     )
                //   ],
                // )
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                voice
                    ? Container(
                        margin: EdgeInsets.only(left: size.width / 10),
                        child: Text(
                          _position.toString().split(".")[0],
                          style: const TextStyle(fontSize: 10),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(left: size.width / 10),
                        child: Text(
                          _duration.toString().split(".")[0],
                          style: const TextStyle(fontSize: 10),
                        ),
                        // durationList[index].toString().split(".")[0]
                      ),
                const Spacer(),
                Text(
                  widget.time,
                  style: getRegularStyle(
                      color: ColorManager.grayLight, fontSize: 9),
                ),
                const SizedBox(
                  width: 2,
                ),
                widget.isSendByme
                    ? Icon(
                        Icons.done_all,
                        color: widget.seen ? Colors.blue : ColorManager.black,
                        size: 12,
                      )
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
