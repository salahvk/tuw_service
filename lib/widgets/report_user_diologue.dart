import 'package:flutter/material.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:social_media_services/API/report_customer.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportUserDiologue extends StatefulWidget {
  const ReportUserDiologue({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportUserDiologue> createState() => _ReportUserDiologueState();
}

class _ReportUserDiologueState extends State<ReportUserDiologue> {
  bool loading = false;

  static const String _report = "Report";
  static const String _loading = "Loading";
  static const String _success = "Success";

  final MultiStateButtonController multiStateButtonController =
      MultiStateButtonController(initialStateName: _report);
  @override
  Widget build(context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          height: size.height * .7,
          width: size.width * .9,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/report.png',
                            width: size.width * .2,
                          ),
                          Text(
                            str.re_report_user,
                            style: getBoldtStyle(
                                color: ColorManager.black, fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 3),
                            child: Text(
                              str.re_bother,
                              style: getRegularStyle(
                                  color: ColorManager.black, fontSize: 15),
                            ),
                          ),
                          Text(
                            str.re_tell_us,
                            style: getRegularStyle(
                                color: ColorManager.black, fontSize: 15),
                          ),
                        ],
                      ),

                      // Text(
                      //   "Reason",
                      //   style: getSemiBoldtStyle(
                      //       color: ColorManager.black, fontSize: 15),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: ColorManager.background,
                                  border: Border.all(
                                      color: ColorManager.paymentPageColor1,
                                      width: .7),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                  minLines: 4,
                                  maxLines: 8,
                                  controller: ReportCustomerControllers
                                      .reasonController,
                                  style: const TextStyle(),
                                  // maxLength: 10,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: const EdgeInsets.only(
                                          left: 4,
                                          right: 10,
                                          top: 0,
                                          bottom: 0),
                                      hintText: str.re_reason2,
                                      hintStyle: getRegularStyle(
                                          color: ColorManager.grayLight,
                                          fontSize: 15)))),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: ColorManager.background,
                                  border: Border.all(
                                      color: ColorManager.paymentPageColor1,
                                      width: .7),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                  minLines: 4,
                                  maxLines: 8,
                                  controller: ReportCustomerControllers
                                      .commentController,
                                  style: const TextStyle(),
                                  // maxLength: 10,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: const EdgeInsets.only(
                                          left: 4,
                                          right: 10,
                                          top: 0,
                                          bottom: 0),
                                      hintText: str.re_comment2,
                                      hintStyle: getRegularStyle(
                                          color: ColorManager.grayLight,
                                          fontSize: 15)))),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      MultiStateButton(
                        multiStateButtonController: multiStateButtonController,
                        buttonStates: [
                          ButtonState(
                              // alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorManager.primary2,
                                borderRadius: BorderRadius.circular(10),
                                // border:
                                //     Border.all(color: ColorManager.black)
                              ),
                              stateName: _report,
                              child: Text(
                                str.we_report,
                              ),
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 20),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(48)),
                            ),
                            size: const Size(48, 48),
                            onPressed: () => multiStateButtonController
                                .setButtonState = _success,
                          ),
                          ButtonState(
                            stateName: _success,
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            decoration: const BoxDecoration(
                              color: ColorManager.primary2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(48)),
                              // shape: BoxShape.circle,
                              // border: Border.all(color: ColorManager.black)
                            ),
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 22),
                            size: const Size(60, 60),
                            onPressed: () => multiStateButtonController
                                .setButtonState = _report,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorManager.whiteColor,
                      child: Icon(
                        Icons.close,
                        color: ColorManager.errorRed,
                        size: 25,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  multiStateFunction(BuildContext context) async {
    // final provider = Provider.of<DataProvider>(context, listen: false);
    final reason = ReportCustomerControllers.reasonController.text;
    final comment = ReportCustomerControllers.commentController.text;
    final str = AppLocalizations.of(context)!;

    if (reason.isEmpty) {
      showAnimatedSnackBar(context, str.re_reason);
      setState(() {});
      return;
    } else if (comment.isEmpty) {
      showAnimatedSnackBar(context, str.re_comment);
      setState(() {});
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    multiStateButtonController.setButtonState = _loading;
    await reportCustomerFun(context);
    // await Future.delayed(const Duration(seconds: 1));

    // provider.isInternetConnected
    //     ? Navigator.pushNamed(context, Routes.splashScreen)
    multiStateButtonController.setButtonState = _success;
    clearReportControllers();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    // // multiStateButtonController.setButtonState = _success;
    // // await Future.delayed(Duration(seconds: 1));
  }
}
