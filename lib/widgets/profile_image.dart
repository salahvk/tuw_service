import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/serviceman%20settings%20profile/worker_admin.dart';
import 'package:http/http.dart' as http;

// import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:social_media_services/API/viewProfile.dart';

class ProfileImage extends StatefulWidget {
  double profileSize = 0;
  double iconSize = 0;
  double iconRadius = 0;
  bool isNavigationActive = false;
  // String? image;
  ProfileImage(
      {Key? key,
      required this.profileSize,
      required this.iconSize,
      required this.isNavigationActive,
      // this.image,
      required this.iconRadius})
      : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: false);
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
            backgroundImage:
                provider.viewProfileModel?.userdetails?.profilePic == null
                    ? null
                    : CachedNetworkImageProvider(
                        "$profileImageApi/${provider.viewProfileModel?.userdetails?.profilePic}",
                      ),
            child: provider.viewProfileModel?.userdetails?.profilePic == null
                ? SvgPicture.asset(
                    'assets/profileAvatar.svg',
                    color: ColorManager.primary,
                  )
                : null,
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
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    upload(image);
  }

  upload(XFile imageFile) async {
    var stream = http.ByteStream(DelegatingStream(imageFile.openRead()));
    var length = await imageFile.length();
    final apiToken = Hive.box("token").get('api_token');
    final provider = Provider.of<DataProvider>(context, listen: false);
    var uri = Uri.parse(updateProfileApi);
    var request = http.MultipartRequest(
      "POST",
      uri,
    );
    // "content-type": "multipart/form-data"
    request.headers
        .addAll({"device-id": provider.deviceId ?? '', "api-token": apiToken});
    var multipartFile = http.MultipartFile(
      'profile_image',
      stream,
      length,
      filename: (imageFile.path),
    );
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    viewProfile(context);
  }

  navigateToWorkersPage() {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return const WorkerDetailedAdmin();
    }));
  }
}
