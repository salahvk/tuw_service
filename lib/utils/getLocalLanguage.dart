import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/main.dart';

String getlocalLanguage(BuildContext context) {
  String lang = Hive.box('LocalLan').get('lang', defaultValue: 'en');
  // if (!mounted) return;
  MyApp.of(context).setLocale(
    Locale.fromSubtags(
      languageCode: lang,
    ),
  );
  print(lang);
  return lang;
}
