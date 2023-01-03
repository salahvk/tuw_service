import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/network_image_url.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/loading%20screens/address_card_loading.dart';
import 'package:social_media_services/loading%20screens/loading_voice_widget.dart';
import 'package:social_media_services/model/view_chat_message_model.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/Google%20Map/share_location.dart';
import 'package:social_media_services/widgets/popup_image.dart';
import 'package:social_media_services/widgets/voice/voice_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomChatBubble extends StatefulWidget {
  ChatData? chatMessage;
  CustomChatBubble({Key? key, this.chatMessage}) : super(key: key);

  @override
  State<CustomChatBubble> createState() => _CustomChatBubbleState();
}

class _CustomChatBubbleState extends State<CustomChatBubble> {
  List latLong = [];
  LatLng? currentLocator;
  GoogleMapController? mapController;

  bool isPdf = false;
  bool isSendByme = false;
  bool isSeen = false;
  String? text;
  String? audio;

  @override
  void initState() {
    super.initState();
    initfunction();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var dateTime = DateFormat("HH:mm")
        .parse(widget.chatMessage!.createdAt!.substring(11, 16), true);
    var hour = dateTime.toLocal().hour;
    var minute = dateTime.toLocal().minute;
    String time =
        widget.chatMessage?.localTime?.substring(11, 16) ?? "$hour:$minute";

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment:
            isSendByme ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  isSendByme ? ColorManager.chatGreen : ColorManager.whiteColor,
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
                  widget.chatMessage?.type == 'image'
                      ? widget.chatMessage?.status == 'waiting'
                          ? ImageLoadingWidget(size: size)
                          : InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => PopupImage(
                                          chatImage:
                                              "$endPoint${widget.chatMessage?.chatMedia}",
                                          image: '',
                                        ),
                                    barrierDismissible: true);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 3),
                                child: SizedBox(
                                  width: size.width * .6,
                                  height: 240,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "$endPoint${widget.chatMessage?.chatMedia}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                      : widget.chatMessage?.type == 'audio'
                          ? widget.chatMessage?.status == 'waiting'
                              ? const LoadingVoice()
                              : VoiceWidget(
                                  path:
                                      "$endPoint${widget.chatMessage?.chatMedia}",
                                  seen: isSeen,
                                  time: time,
                                  isSendByme: isSendByme,
                                )
                          : widget.chatMessage?.type == 'location'
                              ? widget.chatMessage?.status == 'waiting'
                                  ? SizedBox(
                                      height: 140,
                                      width: size.width * .6,
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: SizedBox(
                                        height: 140,
                                        width: size.width * .6,
                                        child: GoogleMap(
                                          // liteModeEnabled: true,
                                          onTap: (argyment) {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (ctx) {
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
                              : widget.chatMessage?.type == 'address_card'
                                  ? InkWell(
                                      onTap: () {
                                        final addressId = widget
                                            .chatMessage?.addressId
                                            .toString();
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (ctx) {
                                          return UserAddressCardLoading(
                                            id: widget.chatMessage!.senderId
                                                .toString(),
                                            addressId: addressId,
                                          );
                                        }));
                                        print(addressId);
                                      },
                                      child: Text(
                                        widget.chatMessage?.message ?? '',
                                        style: getRegularStyle(
                                            color: isSendByme
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
                                            height: size.height * .2,
                                            width: size.width * .3,
                                            decoration: BoxDecoration(
                                                color: isSendByme
                                                    ? ColorManager.chatGreen
                                                    : ColorManager.background,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: isPdf
                                                        ? pdfImage
                                                        : documentImage,
                                                    fit: BoxFit.cover,
                                                    height: size.height * .18,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "${widget.chatMessage?.uploads}",
                                                    style: getRegularStyle(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: 8),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          widget.chatMessage?.message ?? '',
                                          style: getRegularStyle(
                                              color: ColorManager.black,
                                              fontSize: 14),
                                        ),
                  widget.chatMessage?.type != 'audio'
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                time,
                                style: getRegularStyle(
                                    color: ColorManager.grayLight, fontSize: 9),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              widget.chatMessage?.status == 'waiting'
                                  ? const Icon(
                                      FontAwesomeIcons.clock,
                                      size: 10,
                                    )
                                  : isSendByme
                                      ? Icon(
                                          Icons.done_all,
                                          color: isSeen
                                              ? Colors.blue
                                              : ColorManager.black,
                                          size: 12,
                                        )
                                      : Container()
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  initfunction() {
    log("Chat bubble init function");
    print(latLong[0]);
    final provider = Provider.of<DataProvider>(context, listen: false);
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        if (widget.chatMessage?.type == 'location') {
          final locationMessage = '${widget.chatMessage?.message}';
          latLong = locationMessage.split(",");
          currentLocator =
              LatLng(double.parse(latLong[0]), double.parse(latLong[1]));
          mapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLocator!, zoom: 12)));
        }
      }
    });
    // log(widget.location);
    if (widget.chatMessage?.type == 'location') {
      final locationMessage = '${widget.chatMessage?.message}';
      latLong = locationMessage.split(",");
      currentLocator =
          LatLng(double.parse(latLong[0]), double.parse(latLong[1]));
    }
    if (widget.chatMessage?.type == 'document') {
      isPdf = widget.chatMessage?.uploads?.contains('pdf') ?? false;
    }

    if (widget.chatMessage?.senderId ==
        provider.viewProfileModel?.userdetails?.id) {
      isSendByme = true;
    }
    if (widget.chatMessage?.status == 'read') {
      isSeen = true;
    }
  }
}

class ImageLoadingWidget extends StatelessWidget {
  const ImageLoadingWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 3),
      child: SizedBox(
          width: size.width * .6,
          height: 240,
          child: const Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}
