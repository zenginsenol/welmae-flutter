import 'package:flutter/material.dart';

class AppBorderRadius {
  // Small border radius values
  static const BorderRadius none = BorderRadius.zero;
  static const BorderRadius xs = BorderRadius.all(Radius.circular(2.0));
  static const BorderRadius sm = BorderRadius.all(Radius.circular(4.0));
  static const BorderRadius md = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(12.0));
  static const BorderRadius xl = BorderRadius.all(Radius.circular(16.0));
  static const BorderRadius xxl = BorderRadius.all(Radius.circular(24.0));
  static const BorderRadius xxxl = BorderRadius.all(Radius.circular(32.0));

  // Circular border radius
  static const BorderRadius circular = BorderRadius.all(Radius.circular(100.0));

  // Specific corner radius
  static const BorderRadius topLeft = BorderRadius.only(
    topLeft: Radius.circular(8.0),
  );
  static const BorderRadius topRight = BorderRadius.only(
    topRight: Radius.circular(8.0),
  );
  static const BorderRadius bottomLeft = BorderRadius.only(
    bottomLeft: Radius.circular(8.0),
  );
  static const BorderRadius bottomRight = BorderRadius.only(
    bottomRight: Radius.circular(8.0),
  );
}
