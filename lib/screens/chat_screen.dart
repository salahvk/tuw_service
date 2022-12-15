import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/view_chat_messages.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/serviceManLIst.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/servicer_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/utils/snack_bar.dart';
import 'package:social_media_services/widgets/chat_add_tile.dart';
import 'package:social_media_services/widgets/chat_bubble.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

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

  // bool isAnimationVisible = false;
  bool isRecordingOn = false;
  bool isVibrantFeatureAvailable = false;
  String lang = '';
  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  TextEditingController msgController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(const Duration(seconds: 30), (timer) {
        if (mounted) {
          print("recurring Api call");
          final servicerProvider =
              Provider.of<ServicerProvider>(context, listen: false);
          viewChatMessages(context, servicerProvider.servicerId);
        }
      });
    });
    _init();
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
    final str = AppLocalizations.of(context)!;

    final provider = Provider.of<DataProvider>(context, listen: true);
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: true);
    final chatData = provider.viewChatMessageModel?.chatMessage;
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
              radius: 16,
              backgroundImage: provider
                          .serviceManDetails?.userData?.profileImage ==
                      null
                  ? const AssetImage('assets/user.png') as ImageProvider
                  : CachedNetworkImageProvider(
                      '$endPoint${provider.serviceManDetails?.userData?.profileImage}'),
            ),
          ),
          title: InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              //   return ServiceManDetails(
              //     serviceman: widget.serviceman,
              //   );
              // }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " ${provider.serviceManDetails?.userData?.firstname ?? ''} ${provider.serviceManDetails?.userData?.lastname ?? ''}",
                  style:
                      getRegularStyle(color: ColorManager.black, fontSize: 16),
                ),
                Row(
                  children: [
                    Text('',
                        style: getRegularStyle(
                            color: const Color.fromARGB(255, 173, 173, 173),
                            fontSize: 15))
                  ],
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
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 60),
                child: ListView.builder(
                  reverse: true,
                  itemCount: chatData?.data!.length ?? 0,
                  itemBuilder: (context, index) {
                    return CustomChatBubble(
                      isSendByme: chatData?.data![index].senderId ==
                              provider.viewProfileModel?.userdetails?.id
                          ? true
                          : false,
                      seen: true,
                      text: chatData!.data![index].message,
                      image: chatData.data![index].type == 'image'
                          ? "$endPoint${chatData.data![index].chatMedia}"
                          : "",
                      time: "2:05 PM",
                      audio: chatData.data![index].type == 'audio' ? 's' : '',
                    );
                  },
                )
                //  Column(
                //   children: [
                //     CustomChatBubble(
                //         isSendByme: true,
                //         seen: true,
                //         text: 'How can help you',
                //         image: "",
                //         time: "2:05 PM"),
                //     CustomChatBubble(
                //       isSendByme: false,
                //       seen: false,
                //       time: "3:00 PM",
                //       image: switzeland,
                //       text: 'Hi friend',
                //     ),
                //     CustomChatBubble(
                //       isSendByme: true,
                //       seen: false,
                //       time: "5:00 PM",
                //       image: '',
                //       text: 'Where are you now',
                //     ),
                //   ],
                // ),
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
                              onTap: () async {
                                setState(() {
                                  ismenuVisible = false;
                                });
                                await selectImage();
                                await viewChatMessages(
                                    context, servicerProvider.servicerId);
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
                    const SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: () async {
                        _onImageButtonPressed(ImageSource.camera, context);
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
                              showSnackBar(str.cp_long_press, context);
                            },
                            child: const Icon(
                              Icons.mic_none_outlined,
                              size: 30,
                              color: ColorManager.primary,
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              await sendMessages();
                              await viewChatMessages(
                                  context, servicerProvider.servicerId);
                              setState(() {});
                              // print(servicerProvider.servicerId);
                              // await Future.delayed(
                              //     const Duration(milliseconds: 100));
                              // setState(() {});
                              // await Future.delayed(const Duration(seconds: 1));
                              // setState(() {});
                            },
                            child: const Icon(
                              Icons.send,
                              size: 30,
                              color: ColorManager.primary,
                            ),
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

  Future<void> _onImageButtonPressed(
      ImageSource source, BuildContext context) async {
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);
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
      print(pickedFile);
      final list = [pickedFile!];
      await uploadImages(list);
      await viewChatMessages(context, servicerProvider.servicerId);
      await Future.delayed(const Duration(seconds: 2));
      setState(() {});
    } catch (e) {
      setState(() {
        // _pickImageError = e;
      });
    }
    // });
    // }
  }

  // pickGallery() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowMultiple: true,
  //     allowedExtensions: ['jpg', 'mp4', 'png'],
  //   );

  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //     setState(() {
  //       // fileName = file.name;
  //     });
  //   } else {}
  //   setState(() {
  //     ismenuVisible = false;
  //   });
  // }

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

  sendMessages() async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final receiverId = provider.serviceManDetails?.userData?.id.toString();
    provider.subServicesModel = null;
    final apiToken = Hive.box("token").get('api_token');
    final url =
        '$api/chat-store?receiver_id=$receiverId&type=text&message=${msgController.text}&page=1';

    msgController.text = '';
    setState(() {
      ismicVisible = true;
    });
    print(url);
    if (apiToken == null) return;
    try {
      var response = await http.post(Uri.parse(url), headers: {
        "device-id": provider.deviceId ?? '',
        "api-token": apiToken
      });
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        // msgController.text = '';

        // log(response.body);
        // if (jsonResponse['result'] == false) {
        //   await Hive.box("token").clear();

        //   return;
        // }

        // final subServicesData = SubServicesModel.fromJson(jsonResponse);
        // provider.subServicesModelData(subServicesData);
        // selectServiceType(context, id);
      } else {
        // print(response.statusCode);
        // print(response.body);
        // print('Something went wrong');
      }
    } on Exception catch (_) {
      showSnackBar("Something Went Wrong1", context);
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

    final length = imageFile.length;
    var uri =
        Uri.parse('$api/chat-store?receiver_id=$receiverId&type=image&page=1');
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

    if (jsonResponse["result"] == false) {
      showAnimatedSnackBar(
          context, "Images must be a file of type: jpeg, jpg, png.");
      setState(() {});
      return;
    }
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
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          "http://projects.techoriz.in/serviceapp/public/assets/uploads/chatmedia/audio1671101877.ogg")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }
}
