import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media_services/demo/payment_failed.dart';
import 'package:social_media_services/screens/Address%20page/address_page.dart';
import 'package:social_media_services/screens/OTP_screen.dart';
import 'package:social_media_services/screens/Terms&Conditions.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/choose_service_page.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/screens/introduction_screen.dart';
import 'package:social_media_services/screens/mobile_number_screen.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_successfull_page.dart';
import 'package:social_media_services/screens/privacy_policy.dart';
import 'package:social_media_services/screens/profile_page.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/profile_service_man.dart';
import 'package:social_media_services/screens/serviceman/servicer.dart';
import 'package:social_media_services/screens/splash_screen.dart';
import 'package:social_media_services/loading%20screens/wishlist_loading_page.dart';

class Routes {
  static const String splashScreen = '/';
  static const String introductionScreen = '/introductionScreen';
  static const String phoneNumber = '/phoneNumber';
  static const String otpScreen = '/otpScreen';
  // static const String profileDetailsPage = '/profileDetailsPage';
  static const String homePage = '/homePage';
  static const String myProfile = '/myProfile';
  static const String profileServicePage = '/profileServicePage';
  static const String chooseService = '/chooseService';
  static const String paymentSuccessfull = '/paymentSuccessfull';
  static const String paymentServicePage = '/paymentServicePage';
  static const String servicerPage = '/servicerPage';
  static const String chatScreen = '/chatScreen';
  static const String workerDetails = '/workerDetails';
  static const String privacyPolicy = '/privacyPolicy';
  static const String termsAndConditions = '/termsAndConditions';
  static const String wishList = '/wishList';
  static const String addressPage = '/addressPage';
  // static const String noConnectionPage = '/noConnection';
  static const String payFailPage = '/paymentfailed';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const Splash());
      case Routes.introductionScreen:
        return MaterialPageRoute(builder: (_) => const IntroductionScreen());
      case Routes.phoneNumber:
        return MaterialPageRoute(builder: (_) => const PhoneNumberScreen());
      case Routes.otpScreen:
        return MaterialPageRoute(builder: (_) => const OTPscreen());
      // case Routes.profileDetailsPage:
      //   return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.myProfile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case Routes.profileServicePage:
        return MaterialPageRoute(builder: (_) => ProfileServicePage());
      case Routes.chooseService:
        return MaterialPageRoute(builder: (_) => ChooseServicePage());
      case Routes.servicerPage:
        return MaterialPageRoute(builder: (_) => ServicerPage());
      // case Routes.chatScreen:
      //   return MaterialPageRoute(builder: (_) => const ChatScreen());
      // case Routes.workerDetails:
      //   return MaterialPageRoute(builder: (_) => const WorkerDetailed());
      case Routes.privacyPolicy:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const PrivacyPolicy(),
        );
      case Routes.termsAndConditions:
        return MaterialPageRoute(builder: (_) => const TermsAndConditionPage());
      case Routes.wishList:
        return MaterialPageRoute(builder: (_) => const WishList());
      case Routes.addressPage:
        return MaterialPageRoute(builder: (_) => const AddressPage());
      case Routes.paymentSuccessfull:
        return MaterialPageRoute(builder: (_) => const PaymentSuccessPage());
      // case Routes.noConnectionPage:
      //   return MaterialPageRoute(builder: (_) => NoConnectionScreen());
      case Routes.payFailPage:
        return MaterialPageRoute(builder: (_) => PaymentFailurePage());
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
