import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_services/API/delete_gallery_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/screens/serviceman%20settings%20profile/serviceman_profile_view.dart';

class DeleteImage extends StatefulWidget {
  final String imageId;
  const DeleteImage({
    Key? key,
    required this.imageId,
  }) : super(key: key);

  @override
  State<DeleteImage> createState() => _DeleteImageState();
}

class _DeleteImageState extends State<DeleteImage> {
  bool loading = false;
  @override
  Widget build(context) {
    final str = AppLocalizations.of(context)!;
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        height: MediaQuery.of(context).size.height / 2.4,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Delete Image!",
              style: TextStyle(
                  fontFamily: "Open",
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 65),
            SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: LottieBuilder.asset("assets/delete_bin2.json")),
            Text(
              "${str.di_delete2} \n${str.di_delete3}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: "Open", fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      str.di_dont,
                      style: const TextStyle(
                        fontFamily: "Open",
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    )),
                loading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2.5,
                      )
                    : TextButton(
                        onPressed: () async {
                          await deleteImage(widget.imageId);

                          // await deleteAddressBox(widget.imageId);
                        },
                        child: Text(
                          str.di_allow,
                          style: const TextStyle(
                            fontFamily: "Open",
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        )),
              ],
            )
          ],
        ),
      ),
    );
  }

  deleteImage(id) async {
    setState(() {
      loading = true;
    });
    await deleteGalleryImage(context, id);
    await viewProfile(context);
    // await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    navigateToServiceManProfile();
    // setState(() {});
    // setState(() {
    //   loading = false;
    // });
    // Navigator.pushReplacementNamed(context, Routes.addressPage);
  }

  navigateToServiceManProfile() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
      return ServiceManProfileViewPage();
    }));
  }
}
