import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Message",
                    style:
                        getBoldtStyle(color: ColorManager.black, fontSize: 20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Text(
                "Recents",
                style: getRegularStyle(color: ColorManager.black, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
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
                                      backgroundColor: ColorManager.whiteColor
                                          .withOpacity(0.8),
                                      radius: 30,
                                      child: Image.asset(
                                        'assets/user.png',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Positioned(
                                height: 40,
                                // left: size.width * .0,
                                child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor: ColorManager.primary),
                              )
                            ],
                          ),
                          const Text('Darren')
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
