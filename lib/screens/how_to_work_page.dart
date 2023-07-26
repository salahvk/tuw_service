import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/utils/getLocalLanguage.dart';

class HowToWorkPage1 extends StatefulWidget {
  const HowToWorkPage1({super.key});

  @override
  State<HowToWorkPage1> createState() => _HowToWorkPageState();
}

class _HowToWorkPageState extends State<HowToWorkPage1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getlocalLanguage(context);
    });
  }

  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  str.hw_title,
                  style: getRegularStyle(
                      color: ColorManager.grayLight, fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: 250,
                    child: Text(str.hw_title2,
                        softWrap: true,
                        style: getBoldtStyle(
                            color: ColorManager.black, fontSize: 20)),
                  ),
                ),
                Text(
                  str.hw_des,
                  style: getRegularStyle(
                      color: ColorManager.grayLight, fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    str.hw_learn,
                    style: getRegularStyle(
                        color: ColorManager.primary, fontSize: 15),
                  ),
                ),
                Image.asset('1201.png'),
                ExpandableText(
                    mainContent: str.hw_mc_1, subContent: buildRegMob()),
                ExpandableText(
                    mainContent: str.hw_mc_2, subContent: buildRegMob()),
                ExpandableText(
                    mainContent: str.hw_mc_3, subContent: buildRegMob()),
                ExpandableText(
                    mainContent: str.hw_mc_4, subContent: buildRegMob()),
                ExpandableText(
                    mainContent: str.hw_mc_5, subContent: buildRegMob()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.phoneNumber);
                        },
                        child: Text("Proceed")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onPressed;

  ExpandButton({required this.isExpanded, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isExpanded ? Icons.remove_circle : Icons.add_circle,
        size: 32,
        color: Colors.blue,
      ),
      onPressed: onPressed,
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String mainContent;
  final Widget subContent;

  const ExpandableText(
      {super.key, required this.mainContent, required this.subContent});
  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Divider(color: ColorManager.grayLight, thickness: .5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.mainContent,
                      style: getSemiBoldtStyle(
                          color: ColorManager.grayDark, fontSize: 20),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _toggleExpansion,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.grayLight),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      _isExpanded ? '-' : '+',
                      style: TextStyle(
                        color: ColorManager.grayLight,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(color: ColorManager.grayLight, thickness: .5),
          _isExpanded ? widget.subContent : SizedBox(),
        ],
      ),
    );
  }
}

Widget buildRegMob() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        style: getRegularStyle(color: ColorManager.grayLight, fontSize: 15),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.arrow_forward_ios_rounded),
                SizedBox(
                  width: 5,
                ),
                Text("Enter Your Mobile Number",
                    style: getBoldtStyle(
                        color: ColorManager.grayDark, fontSize: 15)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum ha",
                style: getRegularStyle(
                    color: ColorManager.grayLight, fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Image.asset(
                'assets/1201.png',
                height: 120,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.arrow_forward_ios_rounded),
                SizedBox(
                  width: 5,
                ),
                Text("Enter Your Mobile Number",
                    style: getBoldtStyle(
                        color: ColorManager.grayDark, fontSize: 15)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum ha",
                style: getRegularStyle(
                    color: ColorManager.grayLight, fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Image.asset(
                'assets/1201.png',
                height: 120,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
