import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/custom/links.dart';

class WorkerDetailed extends StatelessWidget {
  const WorkerDetailed({super.key});

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
              const CircleAvatar(
                radius: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                child: Text(
                  'Akhil Mahesh',
                  style:
                      getRegularStyle(color: ColorManager.black, fontSize: 16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageAssets.tools),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("Engin Worker",
                      style: getRegularStyle(
                          color: ColorManager.engineWorkerColor, fontSize: 15)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text("Sohar | Oman",
                  style: getRegularStyle(
                      color: ColorManager.engineWorkerColor, fontSize: 15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 40,
                    height: 30,
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
                    child: const Icon(
                      Icons.photo_library_outlined,
                      color: ColorManager.whiteColor,
                    ),
                  )
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
                    width: size.width * .3,
                    color: ColorManager.grayLight,
                    child: CachedNetworkImage(
                      imageUrl: engineWorker1,
                      fit: BoxFit.cover,
                      // cacheManager: customCacheManager,
                    ),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Row(
                  children: [
                    Text(
                      'Description:',
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Text(
                "Lorem Ipsum has been the industry's standard dummy Lorem Ipsum has been the industry's standard dummy.",
                style: getRegularStyle(
                    color: ColorManager.engineWorkerColor, fontSize: 16),
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
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(ImageAssets.car),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("Car",
                      style: getRegularStyle(
                          color: ColorManager.engineWorkerColor, fontSize: 15)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
                child: Row(
                  children: [
                    Text(
                      'More Details:',
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Text(
                "Lorem Ipsum has been the industry's standard dummy Lorem Ipsum has been the industry's standard dummy",
                style: getRegularStyle(
                    color: ColorManager.engineWorkerColor, fontSize: 16),
              ),
              const SizedBox(
                height: 30,
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
                        "BLOCK",
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
