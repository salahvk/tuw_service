import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/screens/worker_admin.dart';

class ProfileImage extends StatefulWidget {
  double profileSize = 0;
  double iconSize = 0;
  double iconRadius = 0;
  bool isNavigationActive = false;
  ProfileImage(
      {Key? key,
      required this.profileSize,
      required this.iconSize,
      required this.isNavigationActive,
      required this.iconRadius})
      : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(4, 4.5),
          ),
        ],
      ),
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: ColorManager.whiteColor.withOpacity(0.8),
            radius: widget.profileSize,
            child: Center(
              child: Image.asset(
                ImageAssets.profileIcon,
              ),
            ),
          ),
          Positioned(
              right: 0,
              bottom: 3,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(2, 2.5),
                    ),
                  ],
                ),
                child: Material(
                  shape: const CircleBorder(),
                  color: ColorManager.whiteColor,
                  child: InkWell(
                    splashColor: ColorManager.primary,
                    customBorder: const CircleBorder(),
                    enableFeedback: true,
                    excludeFromSemantics: true,
                    onTap: () {
                      widget.isNavigationActive
                          ? navigateToWorkersPage()
                          : selectImage();
                    },
                    child: CircleAvatar(
                      radius: widget.iconRadius,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.edit,
                        size: widget.iconSize,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  selectImage() async {
    print("Img picker");
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // final XFile? photo =
    //     await _picker.pickImage(source: ImageSource.camera);
  }

  navigateToWorkersPage() {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return const WorkerDetailedAdmin();
    }));
  }
}
