import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/widgets/servicer_drawer.dart';

class SearchNearService extends StatefulWidget {
  const SearchNearService({super.key});

  @override
  State<SearchNearService> createState() => _SearchNearServiceState();
}

class _SearchNearServiceState extends State<SearchNearService> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawer: SizedBox(
        height: size.height * 0.825,
        width: size.width * 0.54,
        child: const SerDrawer(),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                    height: 48,
                    width: size.width * .8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.grey.shade300,
                              // offset: const Offset(5, 8.5),
                            ),
                          ],
                        ),
                        child: TextField(
                          // focusNode: nfocus,
                          style: const TextStyle(),
                          // controller: nameController,
                          decoration: InputDecoration(
                              suffixIcon: SizedBox(
                                width: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: .5,
                                      height: 48,
                                      color: const Color.fromARGB(
                                          255, 206, 205, 205),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 8, 10, 8),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        String.fromCharCode(
                                            Icons.search.codePoint),
                                        style: TextStyle(
                                          inherit: false,
                                          color: ColorManager.primary,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: Icons.search.fontFamily,
                                          package: Icons.search.fontPackage,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Search near service',
                              hintStyle: getRegularStyle(
                                  color:
                                      const Color.fromARGB(255, 173, 173, 173),
                                  fontSize: 15)),
                        ),
                      ),
                    )),

                // * Filter icon
                const SizedBox(
                  width: 10,
                ),
                Builder(
                  builder: (context) => InkWell(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.grey.shade300,
                            // offset: const Offset(5, 8.5),
                          ),
                        ],
                      ),
                      width: size.width * .09,
                      height: 38,
                      child: const Icon(
                        Icons.filter_alt,
                        size: 25,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
            // * Region
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: size.width * .27,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                          onPressed: () {},
                          child: Text(
                            "Near by",
                            style: getRegularStyle(
                                color: ColorManager.whiteText, fontSize: 15),
                          ))),
                  SizedBox(
                      width: size.width * .3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                          onPressed: () {},
                          child: Text(
                            "Popular",
                            style: getRegularStyle(
                                color: ColorManager.whiteText, fontSize: 15),
                          ))),
                  SizedBox(
                      width: size.width * .3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                          onPressed: () {},
                          child: Text(
                            "Low Cost",
                            style: getRegularStyle(
                                color: ColorManager.whiteText, fontSize: 15),
                          ))),
                ],
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemBuilder: ((context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
            //         child: InkWell(
            //             onTap: () {
            //               Navigator.pushNamed(context, Routes.chatScreen);
            //             },
            //             child: const ServicerListTile()),
            //       );
            //     }),
            //     itemCount: 3,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            //   child: ElevatedButton(
            //       onPressed: () {
            //         // player.stop();
            //       },
            //       style: ElevatedButton.styleFrom(
            //           padding: const EdgeInsets.fromLTRB(30, 0, 30, 0)),
            //       child: Text(
            //         "Continue",
            //         style: getRegularStyle(
            //             color: ColorManager.whiteText, fontSize: 16),
            //       )),
            // ),
          ],
        ),
      )),
    );
  }
}
