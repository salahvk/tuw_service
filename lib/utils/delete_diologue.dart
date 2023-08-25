import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_services/API/address/deleteUserAddress.dart';
import 'package:social_media_services/API/logout.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/utils/initPlatformState.dart';

class DeleteDialogueBox extends StatefulWidget {
  const DeleteDialogueBox({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteDialogueBox> createState() => _DeleteDialogueBoxState();
}

class _DeleteDialogueBoxState extends State<DeleteDialogueBox> {
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
            Text(
              str.delete_account,
              style: const TextStyle(
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
                          setState(() {
                            loading = true;
                          });
                          await deleteAccountFun(context);
                          await Hive.box("token").clear();
                          await initPlatformState(context);
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

  // allowfunction(BuildContext context) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   await Hive.box("token").clear();
  //   callInitFunction(context);
  // }

  // callInitFunction(context) async {
  //   await initPlatformState(context);
  // }
  deleteAddressBox(id) async {
    setState(() {
      loading = true;
    });
    await deleteUserAddress(context, id);
    await viewProfile(context);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, Routes.addressPage);
  }
}
