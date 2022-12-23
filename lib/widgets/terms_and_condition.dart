import 'package:flutter/material.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/responsive/responsive_width.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;

    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.termsAndConditions);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(str.t_1,
                style: getRegularStyle(
                    color: const Color(0xffafafaf),
                    fontSize: mobWth
                        ? 12
                        : smobWth
                            ? 11
                            : 10)),
            Text(str.t_2,
                style: getRegularStyle(
                        color: const Color(0xffafafaf),
                        fontSize: mobWth
                            ? 12
                            : smobWth
                                ? 11
                                : 10)
                    .copyWith(decoration: TextDecoration.underline)),
          ],
        ),
      ),
    );
  }
}
