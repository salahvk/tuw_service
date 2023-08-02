import 'package:flutter/material.dart';

class BackButton2 extends StatelessWidget {
  const BackButton2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.arrow_back_rounded,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
