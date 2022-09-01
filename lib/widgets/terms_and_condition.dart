import 'package:flutter/material.dart';
import 'package:social_media_services/components/styles_manager.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('By continuing, you agree to ',
              style: getRegularStyle(
                  color: const Color(0xffafafaf), fontSize: 13)),
          Text('Terms & Conditions',
              style:
                  getRegularStyle(color: const Color(0xffafafaf), fontSize: 13)
                      .copyWith(decoration: TextDecoration.underline)),
        ],
      ),
    );
  }
}
