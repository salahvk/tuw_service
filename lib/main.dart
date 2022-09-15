import 'package:flutter/material.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/theme_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = const Locale('es', '');
    return MaterialApp(
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('hi', ''), // Hindi
        Locale('ar', ''), // arabic
      ],
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Social Media Services',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(context).copyWith(useMaterial3: true),
      initialRoute: Routes.introductionScreen,
      onGenerateRoute: RouteGenerator.getRoute,
      // home: const SearchNearService(),
    );
  }
}
