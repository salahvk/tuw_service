import 'package:flutter/material.dart';
import 'package:social_media_services/screens/OTP_screen.dart';
import 'package:social_media_services/screens/choose_service_page.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/screens/introduction_screen.dart';
import 'package:social_media_services/screens/mobile_number_screen.dart';
import 'package:social_media_services/screens/edit_profile_screen.dart';
import 'package:social_media_services/screens/profile_page.dart';
import 'package:social_media_services/screens/profile_service_page.dart';
import 'package:social_media_services/screens/servicer.dart';
import 'package:social_media_services/screens/chat_screen.dart';

class Routes {
  static const String introductionScreen = '/';
  static const String phoneNumber = '/phoneNumber';
  static const String otpScreen = '/otpScreen';
  static const String profileDetailsPage = '/profileDetailsPage';
  static const String homePage = '/homePage';
  static const String myProfile = '/myProfile';
  static const String profileServicePage = '/profileServicePage';
  static const String chooseService = '/chooseService';
  static const String paymentSuccessfull = '/paymentSuccessfull';
  static const String paymentServicePage = '/paymentServicePage';
  static const String servicerPage = '/servicerPage';
  static const String chatScreen = '/chatScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.introductionScreen:
        return MaterialPageRoute(builder: (_) => const IntroductionScreen());
      case Routes.phoneNumber:
        return MaterialPageRoute(builder: (_) => const PhoneNumberScreen());
      case Routes.otpScreen:
        return MaterialPageRoute(builder: (_) => const OTPscreen());
      case Routes.profileDetailsPage:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.myProfile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case Routes.profileServicePage:
        return MaterialPageRoute(builder: (_) => const ProfileServicePage());
      case Routes.chooseService:
        return MaterialPageRoute(builder: (_) => const ChooseServicePage());
      case Routes.servicerPage:
        return MaterialPageRoute(builder: (_) => const ServicerPage());
      case Routes.chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(
          child: Text("No Route Found"),
        ),
      ),
    );
  }
}
