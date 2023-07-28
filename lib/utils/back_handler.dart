import 'package:flutter/material.dart';
import 'dart:async';

class BackButtonHandler extends StatefulWidget {
  final Widget child;

  BackButtonHandler({required this.child});

  static _BackButtonHandlerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_BackButtonHandlerState>();
  }

  @override
  _BackButtonHandlerState createState() => _BackButtonHandlerState();
}

class _BackButtonHandlerState extends State<BackButtonHandler> {
  int _backButtonPressCount = 0;

  Future<bool> _onWillPop() async {
    if (_backButtonPressCount == 1) {
      // First back press
      _showTooltip("Press back again to exit");
      _backButtonPressCount++;
      Timer(Duration(seconds: 3), () {
        _backButtonPressCount = 0; // Reset the back press count after 2 seconds
      });
      return true; // Prevent the app from closing
    } else if (_backButtonPressCount == 0) {
      // Initial back press
      _showTooltip("Press back again to exit");
      _backButtonPressCount++;
      Timer(Duration(seconds: 3), () {
        _backButtonPressCount = 0; // Reset the back press count after 2 seconds
      });
      return false; // Prevent the app from closing
    } else {
      // Second back press within 2 seconds, allow the app to exit
      return true;
    }
  }

  void _showTooltip(String message) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy + renderBox.size.height,
        left: position.dx + (renderBox.size.width - 200.0) / 2,
        child: Material(
          color: Colors.transparent,
          child: Tooltip(
            message: message,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Timer(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child,
    );
  }
}
