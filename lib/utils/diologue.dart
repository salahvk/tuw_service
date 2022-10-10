import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_services/utils/initPlatformState.dart';

class DialogueBox extends StatefulWidget {
  const DialogueBox({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogueBox> createState() => _DialogueBoxState();
}

class _DialogueBoxState extends State<DialogueBox> {
  bool loading = false;
  @override
  Widget build(context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        height: MediaQuery.of(context).size.height / 2.4,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Delete the field!",
              style: TextStyle(
                  fontFamily: "Open",
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 65),
            SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                child: LottieBuilder.asset("assets/logout_lottie.json")),
            const Text(
              "Are you sure you want to \nLog out",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Open", fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "I Don't Want To",
                      style: TextStyle(
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
                        onPressed: () {
                          allowfunction(context);
                        },
                        child: const Text(
                          "Allow",
                          style: TextStyle(
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

  allowfunction(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await Hive.box("token").clear();
    callInitFunction(context);
  }

  callInitFunction(context) async {
    await initPlatformState(context);
  }
}
