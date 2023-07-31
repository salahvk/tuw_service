import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/loading%20screens/profile_loading.dart';
import 'package:social_media_services/utils/bottom_nav.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/favoriteServiceTile.dart';
import 'package:social_media_services/widgets/servicer_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WishListPage extends StatefulWidget {
  int? id;
  WishListPage({super.key, this.id});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  String? selectedValue;
  final int _selectedIndex = 2;
  final List<Widget> _screens = [const ServiceHomePage(), const MessagePage()];
  String lang = '';

  bool isPickerSelected = false;
  bool isSerDrawerOpened = false;
  bool isAdvancedSearchEnabled = false;

  List<Countries> r2 = [];
  List<String> r3 = [];
  int? countryid;
  List<Countries> r = [];

  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<DataProvider>(context, listen: false);
      int? n = provider.countriesModel?.countries?.length;
      int i = 0;
      while (i < n!.toInt()) {
        r3.add(provider.countriesModel!.countries![i].countryName!);
        i++;
      }
      provider.servicerSelectedCountry = '';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: false);
    final favoriteServiceMan = provider.serviceManListFavoriteModel?.favorites;

    return GestureDetector(
      onTap: () {
        setState(() {
          isPickerSelected = false;
        });
      },
      child: Scaffold(
        onEndDrawerChanged: (isOpened) async {
          setState(() {});
          await Future.delayed(const Duration(seconds: 2));
          setState(() {});
        },

        drawerEnableOpenDragGesture: false,
        endDrawer: SizedBox(
          height: size.height * 0.825,
          width: isSerDrawerOpened ? size.width * 0.54 : size.width * 0.6,
          child: isSerDrawerOpened
              ? SerDrawer(
                  id: widget.id,
                )
              : const CustomDrawer(),
        ),
        // * Custom bottom Nav
        // appBar: AppBar(
        //   title: Text(
        //     str.w_wishList,
        //     style: getMediumtStyle(color: ColorManager.black, fontSize: 22),
        //   ),
        //   centerTitle: true,
        // ),
        bottomNavigationBar: BottomNavigationWidget(
          isInsidePage: true,
          selectedIndex: 3,
        ),
        body: _selectedIndex != 2
            ? _screens[_selectedIndex]
            : SafeArea(
                child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            str.w_wishList,
                            style: getMediumtStyle(
                                color: ColorManager.black, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (ctx) {
                                        return ProfileLoading(
                                          serviceId: favoriteServiceMan![index]
                                              .id
                                              .toString(),
                                        );
                                      }));
                                    },
                                    child: FavoriteServiceListTile(
                                      serviceman: favoriteServiceMan![index],
                                    )),
                              );
                            }),
                            itemCount: favoriteServiceMan?.length ?? 0,
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
      ),
    );
  }
}
