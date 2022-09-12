import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [Image.asset(ImageAssets.privacy)],
          )
        ],
      ),
    );
  }
}
