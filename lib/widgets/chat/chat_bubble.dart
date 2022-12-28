import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:social_media_services/loading%20screens/address_card_loading.dart';
import 'package:social_media_services/model/view_chat_message_model.dart';
import 'package:social_media_services/screens/Google%20Map/share_location.dart';
import 'package:social_media_services/widgets/chat/common.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_session/audio_session.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomChatBubble extends StatefulWidget {
  final bool isSendByme;
  final bool seen;
  String? text;
  String audio;
  final String time;
  String image;
  String location;
  String addressCard;
  String senderId;
  Data? chatMessage;
  CustomChatBubble(
      {Key? key,
      this.text,
      required this.audio,
      required this.image,
      required this.isSendByme,
      required this.time,
      required this.seen,
      required this.addressCard,
      required this.senderId,
      required this.location,
      this.chatMessage})
      : super(key: key);

  @override
  State<CustomChatBubble> createState() => _CustomChatBubbleState();
}

class _CustomChatBubbleState extends State<CustomChatBubble> {
  final _player = AudioPlayer();
  List latLong = [];
  LatLng? currentLocator;
  GoogleMapController? mapController;
  @override
  void initState() {
    super.initState();
    _init();
    log("Chat Bubble initiated");
    log("hi");
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        _init();
      }
    });
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        if (widget.location.isNotEmpty) {
          latLong = widget.location.split(",");
          currentLocator =
              LatLng(double.parse(latLong[0]), double.parse(latLong[1]));
          mapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLocator!, zoom: 12)));
        }
      }
    });
    log(widget.location);
    if (widget.location.isNotEmpty) {
      latLong = widget.location.split(",");
      currentLocator =
          LatLng(double.parse(latLong[0]), double.parse(latLong[1]));
    }
    // print(widget.location);

    // print(latLong);
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(
          AudioSource.uri(Uri.parse("$endPoint${widget.audio}")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var dateTime = DateFormat("HH:mm").parse(widget.time, true);
    var hour = dateTime.toLocal().hour;
    var minute = dateTime.toLocal().minute;

    // print(hour);
    // print(DateTime.now());

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment:
            widget.isSendByme ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.isSendByme
                  ? ColorManager.whiteColor
                  : ColorManager.primary,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.grey.shade300,
                  offset: const Offset(5, 8.5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  widget.image.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            // PopupImage(image: widget.image);
                            // print("object");
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 3),
                            child: SizedBox(
                              width: size.width * .6,
                              height: 240,
                              child: CachedNetworkImage(
                                imageUrl: widget.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : widget.audio.isNotEmpty
                          ? SizedBox(
                              // width: size.width,
                              height: 50,
                              // color: ColorManager.primary,
                              child: Row(
                                children: [
                                  ControlButtons(_player),
                                  StreamBuilder<PositionData>(
                                    stream: _positionDataStream,
                                    builder: (context, snapshot) {
                                      final positionData = snapshot.data;
                                      return SeekBar(
                                        duration: positionData?.duration ??
                                            Duration.zero,
                                        position: positionData?.position ??
                                            Duration.zero,
                                        bufferedPosition:
                                            positionData?.bufferedPosition ??
                                                Duration.zero,
                                        onChangeEnd: _player.seek,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : widget.location.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: SizedBox(
                                    height: 140,
                                    width: size.width * .6,
                                    child: GoogleMap(
                                      liteModeEnabled: true,
                                      onTap: (argyment) {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (ctx) {
                                          return ShareLocation(
                                            currentLocator: currentLocator,
                                          );
                                        }));
                                      },
                                      // myLocationEnabled: true,
                                      zoomControlsEnabled: false,
                                      // zoomGesturesEnabled: false,
                                      onMapCreated: (controller) {
                                        setState(() {
                                          mapController = controller;
                                        });
                                      },
                                      initialCameraPosition: CameraPosition(
                                        target: currentLocator ??
                                            const LatLng(0, 0),
                                        zoom: 12.0,
                                      ),
                                      markers: <Marker>{
                                        Marker(
                                          markerId: const MarkerId(''),
                                          position: currentLocator ??
                                              const LatLng(0, 0),
                                          // infoWindow: const InfoWindow(
                                          //   title: 'Home locator',
                                          //   snippet: '*',
                                          // ),
                                        ),
                                      },
                                    ),
                                  ),
                                )
                              : widget.addressCard.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        final addressId = widget
                                            .chatMessage?.addressId
                                            .toString();
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (ctx) {
                                          return UserAddressCardLoading(
                                            id: widget.senderId,
                                            addressId: addressId,
                                          );
                                        }));
                                        print(addressId);
                                      },
                                      child: Text(
                                        widget.text ?? '',
                                        style: getRegularStyle(
                                            color: widget.isSendByme
                                                ? ColorManager.primary3
                                                : ColorManager.whiteColor,
                                            fontSize: 14),
                                      ),
                                    )
                                  : widget.chatMessage?.type == 'document'
                                      ? InkWell(
                                          onTap: () {
                                            final url = Uri.parse(
                                                "$endPoint${widget.chatMessage?.chatMedia}");
                                            print(url);
                                            launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Container(
                                            height: 60,
                                            width: size.width * .6,
                                            decoration: BoxDecoration(
                                                color: widget.isSendByme
                                                    ? ColorManager.primary
                                                    : ColorManager.background,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.file_copy),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    "${widget.chatMessage?.uploads}",
                                                    style: getRegularStyle(
                                                        color:
                                                            ColorManager.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          widget.text ?? '',
                                          style: getRegularStyle(
                                              color: ColorManager.black,
                                              fontSize: 14),
                                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "$hour:$minute",
                          style: getRegularStyle(
                              color: ColorManager.grayLight, fontSize: 9),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.done_all,
                          color: widget.seen ? Colors.blue : ColorManager.black,
                          size: 12,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        // IconButton(
        //   icon: const Icon(Icons.volume_up),
        //   onPressed: () {
        //     showSliderDialog(
        //       context: context,
        //       title: "Adjust volume",
        //       divisions: 10,
        //       min: 0.0,
        //       max: 1.0,
        //       value: player.volume,
        //       stream: player.volumeStream,
        //       onChanged: player.setVolume,
        //     );
        //   },
        // ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 44.0,
                height: 44.0,
                child: const Icon(
                  Icons.play_arrow,
                  size: 44,
                  color: ColorManager.grayLight,
                ),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 44.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 44.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 44.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}
