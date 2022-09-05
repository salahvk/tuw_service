import 'package:flutter/material.dart';
import 'package:social_media_services/components/styles_manager.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  const CustomTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.grey.shade300,
              // offset: const Offset(5, 8.5),
            ),
          ],
        ),
        child: TextField(
          // focusNode: nfocus,
          style: const TextStyle(),
          // controller: nameController,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: getRegularStyle(
                  color: const Color.fromARGB(255, 173, 173, 173),
                  fontSize: 15)),
        ),
      ),
    );
  }
}
