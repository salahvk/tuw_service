import 'package:flutter/material.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media Services',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(context).copyWith(useMaterial3: true),
      initialRoute: Routes.introductionScreen,
      onGenerateRoute: RouteGenerator.getRoute,
      // home: const ProfileServicePage(),
    );
  }
}
