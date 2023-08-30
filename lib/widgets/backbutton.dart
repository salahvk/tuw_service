import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackButton2 extends StatefulWidget {
  const BackButton2({
    super.key,
  });

  @override
  State<BackButton2> createState() => _BackButton2State();
}

class _BackButton2State extends State<BackButton2> {
  String lang = '';
  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    print(lang);
  }

  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    print(lang);
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            lang == 'ar'
                ? Transform.rotate(
                    angle: 3.14159,
                    child: Text(
                      textAlign: TextAlign.center,
                      String.fromCharCode(
                          Icons.arrow_back_ios_rounded.codePoint),
                      style: TextStyle(
                        inherit: false,
                        color: ColorManager.primary,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: Icons.search.fontFamily,
                        package: Icons.arrow_back_ios_rounded.fontPackage,
                      ),
                    ),
                  )
                : Text(
                    textAlign: TextAlign.center,
                    String.fromCharCode(Icons.arrow_back_ios_rounded.codePoint),
                    style: TextStyle(
                      inherit: false,
                      color: ColorManager.primary,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: Icons.search.fontFamily,
                      package: Icons.arrow_back_ios_rounded.fontPackage,
                    ),
                  ),
            Text(
              str.back,
              style: getRegularStyle(color: ColorManager.black, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
