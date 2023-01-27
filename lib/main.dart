import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/theme_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/otp_provider.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:social_media_services/providers/servicer_provider.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_integaration/providers/payment_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("LocalLan");
  await Hive.openBox("token");
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
// ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  String lang = '';
  Locale locale = const Locale('en', '');

  void setLocale(Locale value) async {
    setState(() {
      locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DataProvider()),
          ChangeNotifierProvider(create: (_) => OTPProvider()),
          ChangeNotifierProvider(create: (_) => ServicerProvider()),
          ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ],
        child: MaterialApp(
          supportedLocales: const [
            Locale('en', ''), // English
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
          title: 'Tuw Services',
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(context).copyWith(useMaterial3: true),
          initialRoute: Routes.splashScreen,
          onGenerateRoute: RouteGenerator.getRoute,
          // home: const UserAddressCardLoading()
        ));
  }
}
