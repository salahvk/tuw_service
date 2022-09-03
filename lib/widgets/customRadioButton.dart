import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';

class CustomizedRadioButton extends StatefulWidget {
  final String gender;
  final bool isMaleSelected;
  final GestureTapCallback? onTap;
  const CustomizedRadioButton(
      {Key? key,
      this.onTap,
      required this.isMaleSelected,
      required this.gender})
      : super(key: key);

  @override
  State<CustomizedRadioButton> createState() => _CustomizedRadioButtonState();
}

class _CustomizedRadioButtonState extends State<CustomizedRadioButton> {
  // bool isMaleSelected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey.shade400,
              offset: const Offset(3, 3),
            )
          ],
        ),
        child: CircleAvatar(
          radius: 9,
          backgroundColor: widget.gender == "MALE"
              ? widget.isMaleSelected
                  ? ColorManager.primary
                  : ColorManager.whiteColor
              : !widget.isMaleSelected
                  ? ColorManager.primary
                  : ColorManager.whiteColor,
        ),
      ),
    );
  }
}
