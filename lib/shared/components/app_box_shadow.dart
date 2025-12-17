import 'package:flutter/material.dart';

class AppBoxShadow {
  static BoxShadow boxShadow({
    Color color = Colors.black,
    double opacity = 0.08,
    Offset offset = const Offset(0, 4),
    double blurRadius = 4,
    double spreadRadius = -7,
  }) {
    return BoxShadow(
      color: color.withOpacity(opacity),
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );
  }
}
