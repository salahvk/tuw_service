import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScrollableDialogBox extends StatefulWidget {
  final List<String> images;

  ScrollableDialogBox({required this.images});

  @override
  _ScrollableDialogBoxState createState() => _ScrollableDialogBoxState();
}

class _ScrollableDialogBoxState extends State<ScrollableDialogBox> {
  int currentIndex = 0;

  // Function to show the next image
  void showNextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.images.length;
    });
    print(currentIndex);
    print(widget.images.length);
  }

  // Function to show the previous image
  void showPreviousImage() {
    setState(() {
      currentIndex =
          (currentIndex - 1 + widget.images.length) % widget.images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      child: Stack(
        children: [
          SizedBox(
            height: size.height * 0.7,
            width: size.width * 0.9,
            child: CachedNetworkImage(
              imageUrl: widget.images[currentIndex],
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: showPreviousImage,
                  icon: Icon(Icons.arrow_back_ios),
                ),
                IconButton(
                  onPressed: showNextImage,
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
