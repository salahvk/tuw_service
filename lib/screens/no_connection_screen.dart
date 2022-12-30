import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoConnectionScreen extends StatelessWidget {
  static const String _tryAgain = "Try Again";
  static const String _loading = "Loading";
  static const String _success = "Success";

  final MultiStateButtonController multiStateButtonController =
      MultiStateButtonController(initialStateName: _tryAgain);
  NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                // fit: BoxFit.fitWidth,
                ImageAssets.noConnection,
                repeat: true,
              ),
              // Spacer(),
              Text(
                str.no_oops,
                style: getBoldtStyle(color: ColorManager.primary, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${str.no_connection}\n${str.no_check_connection}',
                textAlign: TextAlign.center,
                style:
                    getBoldtStyle(color: ColorManager.errorRed, fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              MultiStateButton(
                multiStateButtonController: multiStateButtonController,
                buttonStates: [
                  ButtonState(
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorManager.primary2,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorManager.black)),
                      stateName: _tryAgain,
                      child: const Text(
                        _tryAgain,
                      ),
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      size: const Size(160, 48),
                      onPressed: () {
                        multiStateFunction(context);
                      }),
                  ButtonState(
                    stateName: _loading,
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(48)),
                    ),
                    size: const Size(48, 48),
                    onPressed: () =>
                        multiStateButtonController.setButtonState = _success,
                  ),
                  ButtonState(
                    stateName: _success,
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    decoration: const BoxDecoration(
                      color: ColorManager.primary2,
                      borderRadius: BorderRadius.all(Radius.circular(48)),
                      // shape: BoxShape.circle,
                      // border: Border.all(color: ColorManager.black)
                    ),
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 22),
                    size: const Size(60, 60),
                    onPressed: () =>
                        multiStateButtonController.setButtonState = _tryAgain,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  multiStateFunction(BuildContext context) async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    multiStateButtonController.setButtonState = _loading;
    await Future.delayed(const Duration(seconds: 1));
    provider.isInternetConnected
        ? Navigator.pushNamed(context, Routes.splashScreen)
        : multiStateButtonController.setButtonState = _tryAgain;
    // multiStateButtonController.setButtonState = _success;
    // await Future.delayed(Duration(seconds: 1));
  }
}
