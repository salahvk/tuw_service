import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/widgets/title_widget.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  DateTime selectedDate = DateTime.now();
  String? gender;
  bool male = false;
  bool female = false;
  FocusNode nfocus = FocusNode();
  FocusNode dobfocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
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
                            backgroundColor:
                                ColorManager.whiteColor.withOpacity(0.8),
                            radius: 40.5,
                            child: Center(
                              child: Image.asset(
                                ImageAssets.profileIcon,
                              ),
                            ),
                          ),
                          const Positioned(
                              right: 0,
                              bottom: 3,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: ColorManager.whiteColor,
                                child: Icon(
                                  Icons.edit,
                                  size: 12,
                                  color: ColorManager.primary,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TitleWidget(name: 'Name'),
              ),
              Padding(
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
                    focusNode: nfocus,
                    style: const TextStyle(),
                    decoration: InputDecoration(
                        hintText: 'Enter Name',
                        hintStyle: getRegularStyle(
                            color: const Color.fromARGB(255, 173, 173, 173),
                            fontSize: 15)),
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: TitleWidget(name: 'Date of Birth'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Container(
                          width: size.width * 0.5,
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
                            style: const TextStyle(),
                            readOnly: true,
                            controller: dateController,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () => _selectDate(context),
                                  child: const Icon(
                                    Icons.calendar_month,
                                    color: ColorManager.primary,
                                  ),
                                ),
                                hintText: 'Enter Date of Birth',
                                hintStyle: getRegularStyle(
                                    color: const Color.fromARGB(
                                        255, 173, 173, 173),
                                    fontSize: 14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TitleWidget(name: 'Gender'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      color: Colors.grey.shade400,
                                      offset: const Offset(3, 3),
                                    )
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundColor: male
                                      ? ColorManager.primary
                                      : ColorManager.whiteColor,
                                  child: Radio(
                                    fillColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                    value: "Male",
                                    overlayColor: MaterialStateProperty.all(
                                        ColorManager.primary),
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                        male = true;
                                        female = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const TitleWidget(name: 'Male'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      color: Colors.grey.shade400,
                                      offset: const Offset(3, 3),
                                    )
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundColor: female
                                      ? ColorManager.primary
                                      : ColorManager.whiteColor,
                                  child: Radio(
                                    fillColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                    value: "female",
                                    overlayColor: MaterialStateProperty.all(
                                        ColorManager.primary),
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();

                                        female = true;
                                        male = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const TitleWidget(name: 'Female'),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: TitleWidget(name: 'Country'),
              ),
              Padding(
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
                    style: const TextStyle(),
                    decoration: InputDecoration(
                        hintText: 'Enter Country',
                        hintStyle: getRegularStyle(
                            color: const Color.fromARGB(255, 173, 173, 173),
                            fontSize: 15)),
                  ),
                ),
              ),
              // * Region
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: TitleWidget(name: 'Region'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                        child: Container(
                          width: size.width * .44,
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
                            style: const TextStyle(),
                            decoration: InputDecoration(
                                hintText: 'Enter Region',
                                hintStyle: getRegularStyle(
                                    color: const Color.fromARGB(
                                        255, 173, 173, 173),
                                    fontSize: 15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: TitleWidget(name: 'State'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Container(
                          width: size.width * .44,
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
                            style: const TextStyle(),
                            decoration: InputDecoration(
                                hintText: 'Enter State',
                                hintStyle: getRegularStyle(
                                    color: const Color.fromARGB(
                                        255, 173, 173, 173),
                                    fontSize: 15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: TitleWidget(name: 'About'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
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
                  child: SizedBox(
                    child: TextField(
                      minLines: 4,
                      maxLines: 5,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          hintText: 'Enter About',
                          hintStyle: getRegularStyle(
                              color: const Color.fromARGB(255, 173, 173, 173),
                              fontSize: 15)),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 20, vertical: 5),
                  //     ),
                  //     onPressed: () {},
                  //     child: const Text(
                  //       'CHANGE \nMOBILE NO',
                  //       textAlign: TextAlign.center,
                  //     )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 16),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) {
                            return const HomePage();
                          }));
                        },
                        child: Center(
                          child: Text(
                            'SAVE',
                            textAlign: TextAlign.justify,
                            style: getRegularStyle(
                                color: ColorManager.whiteText, fontSize: 15),
                          ),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // * Date selection

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme:
                    const ColorScheme.light(primary: ColorManager.primary)),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }
}
