import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/custom/links.dart';
import 'package:social_media_services/widgets/statusListTile.dart';

class WorkerDetailedAdmin extends StatefulWidget {
  const WorkerDetailedAdmin({super.key});

  @override
  State<WorkerDetailedAdmin> createState() => _WorkerDetailedAdminState();
}

class _WorkerDetailedAdminState extends State<WorkerDetailedAdmin> {
  bool isStatusVisible = false;
  String checkBoxValue = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 45,
                              backgroundColor: ColorManager.background,
                              child: CircleAvatar(
                                radius: 40,
                              ),
                            ),
                            Positioned(
                                top: 10,
                                left: 5,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isStatusVisible = !isStatusVisible;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: ColorManager.primary,
                                    child: isStatusVisible
                                        ? const Icon(Icons.keyboard_arrow_up)
                                        : const Icon(Icons.keyboard_arrow_down),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isStatusVisible
                      ? Positioned(
                          left: size.width * .17,
                          top: 22,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(5)),
                            width: 95,
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 8, 0, 0),
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          checkBoxValue = 'Online';
                                        });
                                      },
                                      child: StatusLIstTile(
                                        checkBoxValue: checkBoxValue,
                                        title: "Online",
                                      )),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          checkBoxValue = 'Offline';
                                        });
                                      },
                                      child: StatusLIstTile(
                                        checkBoxValue: checkBoxValue,
                                        title: "Offline",
                                      )),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          checkBoxValue = 'Busy';
                                        });
                                      },
                                      child: StatusLIstTile(
                                        checkBoxValue: checkBoxValue,
                                        title: "Busy",
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                child: Text(
                  'Akhil Mahesh',
                  style:
                      getRegularStyle(color: ColorManager.black, fontSize: 16),
                ),
              ),
              Container(
                height: 35,
                width: 170,
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.grey.shade300,
                      offset: const Offset(5, 8.5),
                    ),
                  ],
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Image.asset(ImageAssets.tools),
                    ),
                    Text("Engin Worker",
                        style: getRegularStyle(
                            color: ColorManager.engineWorkerColor,
                            fontSize: 15)),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                      child: Image.asset(ImageAssets.penEdit),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 35,
                width: 170,
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.grey.shade300,
                      offset: const Offset(5, 8.5),
                    ),
                  ],
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text("Sohar | Oman",
                          style: getRegularStyle(
                              color: ColorManager.engineWorkerColor,
                              fontSize: 15)),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 25,
                        color: ColorManager.black,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // * Add image start
                  Container(
                      width: 30,
                      height: 21,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 9.5,
                            color: Colors.grey.shade400,
                            offset: const Offset(6, 6),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: ColorManager.whiteColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          ImageAssets.addImage,
                          fit: BoxFit.contain,
                        ),
                      )),
                  const SizedBox(
                    width: 3,
                  ),

                  // * Image gallery start
                  Container(
                      width: 30,
                      height: 21,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 9.5,
                            color: Colors.grey.shade400,
                            offset: const Offset(6, 6),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: ColorManager.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          ImageAssets.gallery,
                          fit: BoxFit.contain,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 80,
                    width: size.width * .28,
                    color: ColorManager.grayLight,
                    child: CachedNetworkImage(
                      imageUrl: engineWorker1,
                      fit: BoxFit.cover,
                      // cacheManager: customCacheManager,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                    height: 80,
                    width: size.width * .3,
                    color: ColorManager.grayLight,
                    child: CachedNetworkImage(
                      imageUrl: engineWorker1,
                      fit: BoxFit.cover,
                      // cacheManager: customCacheManager,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Container(
                    height: 80,
                    width: size.width * .28,
                    color: ColorManager.grayLight,
                    child: CachedNetworkImage(
                      imageUrl: engineWorker1,
                      fit: BoxFit.cover,
                      // cacheManager: customCacheManager,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: DescriptionEditWidget(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Row(
                  children: [
                    Text(
                      'Service Type:',
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset(
                        ImageAssets.tools,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("Engine Mechanic",
                        style: getRegularStyle(
                            color: ColorManager.engineWorkerColor,
                            fontSize: 15)),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Transport:',
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: 16),
                  ),
                  SizedBox(
                    width: size.width * .06,
                  ),
                  Container(
                    height: 35,
                    width: 170,
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10.0,
                          color: Colors.grey.shade300,
                          offset: const Offset(5, 8.5),
                        ),
                      ],
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(ImageAssets.car),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("Car",
                            style: getRegularStyle(
                                color: ColorManager.engineWorkerColor,
                                fontSize: 15)),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 25,
                          color: ColorManager.black,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 8),
                child: DescriptionEditWidget(),
              ),
              const SizedBox(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        // player.stop();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(33, 0, 33, 0)),
                      child: Text(
                        "REPORT",
                        style: getMediumtStyle(
                            color: ColorManager.whiteText, fontSize: 14),
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("Save pdf");
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(33, 0, 33, 0)),
                      child: Text(
                        "SAVE",
                        style: getMediumtStyle(
                            color: ColorManager.whiteText, fontSize: 14),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionEditWidget extends StatelessWidget {
  const DescriptionEditWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
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
        padding: const EdgeInsets.fromLTRB(15, 5, 10, 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Image.asset(ImageAssets.penEdit)],
            ),
            Row(
              children: [
                Text(
                  'Description:',
                  style:
                      getRegularStyle(color: ColorManager.black, fontSize: 16),
                ),
              ],
            ),
            Text(
              "Lorem Ipsum has been the industry's standard dummy Lorem Ipsum has been the industry's standard dummy.",
              style: getRegularStyle(
                  color: ColorManager.engineWorkerColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
