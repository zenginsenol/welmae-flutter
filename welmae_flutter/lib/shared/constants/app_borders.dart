import 'package:flutter/material.dart';

class AppBorders {
  // No border
  static const BorderSide none = BorderSide.none;

  // Thin borders
  static const BorderSide xs = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs2 = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 1.0,
    style: BorderStyle.solid,
  );

  static const BorderSide xs3 = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 1.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs4 = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 2.0,
    style: BorderStyle.solid,
  );

  // Thin borders with different colors
  static const BorderSide xsPrimary = BorderSide(
    color: Color(0xFF6366F1),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xsSecondary = BorderSide(
    color: Color(0xFF64748B),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xsSuccess = BorderSide(
    color: Color(0xFF10B981),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xsWarning = BorderSide(
    color: Color(0xFFF59E0B),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xsError = BorderSide(
    color: Color(0xFFEF4444),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xsInfo = BorderSide(
    color: Color(0xFF3B82F6),
    width: 0.5,
    style: BorderStyle.solid,
  );

  // Thin borders with different styles - using custom painters or other approaches
  // Note: BorderStyle.dashed, BorderStyle.dotted, BorderStyle.double are not valid in Flutter
  static const BorderSide xsDashed = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 0.5,
    // style: BorderStyle.solid, // Using solid as dashed is not a valid enum value
  );

  static const BorderSide xsDotted = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 0.5,
    // style: BorderStyle.solid, // Using solid as dotted is not a valid enum value
  );

  static const BorderSide xsDouble = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 0.5,
    // style: BorderStyle.solid, // Using solid as double is not a valid enum value
  );

  // Thin borders with different widths
  static const BorderSide xs05 = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 0.25,
    style: BorderStyle.solid,
  );

  static const BorderSide xs075 = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 0.375,
    style: BorderStyle.solid,
  );

  static const BorderSide xs125 = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 0.625,
    style: BorderStyle.solid,
  );

  static const BorderSide xs175 = BorderSide(
    color: Color(0xFFE5E7EB),
    width: 0.875,
    style: BorderStyle.solid,
  );

  // Thin borders with different opacities
  static const BorderSide xs10 = BorderSide(
    color: Color(0x1A000000),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs20 = BorderSide(
    color: Color(0x33000000),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs30 = BorderSide(
    color: Color(0x4D000000),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs40 = BorderSide(
    color: Color(0x66000000),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs50 = BorderSide(
    color: Color(0x80000000),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs60 = BorderSide(
    color: Color(0x99000000),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs70 = BorderSide(
    color: Color(0xB3000000),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs80 = BorderSide(
    color: Color(0xCC000000),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs90 = BorderSide(
    color: Color(0xE6000000),
    width: 0.5,
    style: BorderStyle.solid,
  );

  static const BorderSide xs100 = BorderSide(
    color: Color(0xFF000000),
    width: 0.5,
    style: BorderStyle.solid,
  );
}
