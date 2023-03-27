import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/di/di_manager.dart';
import 'app_colors.dart';
import 'app_style.dart';

class AppFont {
  AppFont._();

  static double fontHeight = 1.2;

  static TextTheme getTextTheme(TextTheme textTheme) =>
      GoogleFonts.montserratTextTheme(textTheme.copyWith(
        bodyLarge: AppStyle.defaultStyle,
        bodyMedium: AppStyle.defaultStyle,
      ));

  static TextStyle get textStyle => GoogleFonts.roboto();
}

class AppFontSize {
  AppFontSize._();

  // static double get _scaleFactor => 0.65;
  static double get _scaleFactor => 1.15;

  /// Font sizes
  static double get fontSize_8 => 8 * _scaleFactor;

  static double get fontSize_10 => 10 * _scaleFactor;

  static double get fontSize_11 => 11 * _scaleFactor;

  static double get fontSize_12 => 12 * _scaleFactor;

  static double get fontSize_13 => 13 * _scaleFactor;

  static double get fontSize_14 => 14 * _scaleFactor;

  static double get fontSize_16 => 16 * _scaleFactor;

  static double get fontSize_18 => 18 * _scaleFactor;

  static double get fontSize_20 => 20 * _scaleFactor;

  static double get fontSize_25 => 25 * _scaleFactor;

  static double get fontSize_30 => 30 * _scaleFactor;

  static double get fontSize_40 => 40 * _scaleFactor;
}

class AppFontWeight {
  AppFontWeight._();

  static FontWeight light = FontWeight.w300;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight regular = FontWeight.normal;
  static FontWeight bold = FontWeight.bold;
}

class AppFontStyle {
  static TextStyle get normalTitle => TextStyle(
      color: DIManager.findDep<AppColorsController>().black,
      fontWeight: AppFontWeight.bold,
      fontSize: AppFontSize.fontSize_14);

  static TextStyle get formFieldStyle => TextStyle(
      color: DIManager.findDep<AppColorsController>().black,
      fontWeight: AppFontWeight.regular,
      fontSize: AppFontSize.fontSize_14);
}
