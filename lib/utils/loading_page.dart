import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/responsive/responsive.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  void initState() {
    super.initState();
  }

  final bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final mob = Responsive.isMobile(context);
    // final str = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.green,
                enabled: _enabled,
                period: const Duration(milliseconds: 1500),
                direction: ShimmerDirection.ltr,
                loop: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: mob ? 130 : 100,
                          childAspectRatio: 3 / 3,
                          crossAxisSpacing: 14,
                          mainAxisExtent: mob ? 123 : 100,
                          mainAxisSpacing: 20),
                      itemCount: 50,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.grey.shade300,
                                    offset: const Offset(2, 2.5),
                                  ),
                                ],
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: mob ? 70.0 : 50,
                                  height: mob ? 70.0 : 50,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //   child: FlatButton(
            //       onPressed: () {
            //         setState(() {
            //           _enabled = !_enabled;
            //         });
            //       },
            //       child: Text(
            //         _enabled ? 'Stop' : 'Play',
            //         style: Theme.of(context).textTheme.button!.copyWith(
            //             fontSize: 18.0,
            //             color: _enabled ? Colors.redAccent : Colors.green),
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}
