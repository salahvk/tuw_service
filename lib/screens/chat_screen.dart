import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/camera_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool ismicVisible = true;
  bool ismenuVisible = false;
  bool isMapmenuVisible = false;
  @override
  Widget build(BuildContext context) {
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
                        ? const Icon(
                            Icons.mic_none_outlined,
                            size: 30,
                            color: ColorManager.primary,
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
            )
          ],
        ),
      ),
    );
  }
}

class ChatAddTile extends StatelessWidget {
  final String title;
  final String image;
  const ChatAddTile({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 25,
          height: 25,
          child: Image.asset(
            image,
            color: ColorManager.whiteColor,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(title,
            style: getBoldtStyle(color: ColorManager.whiteColor, fontSize: 15))
      ],
    );
  }
}
