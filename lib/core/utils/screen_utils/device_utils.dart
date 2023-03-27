import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenHelper {
  static double? width55;
  static double? height55;
  static late double width;
  static late double height;
  static ScreenUtil? _screenUtil;
  static late MediaQueryData _mediaQueryData;
  static double? screenWidth;
  static late double screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  static get statusBarHeight => _screenUtil?.statusBarHeight ?? 0;

  ScreenHelper(BuildContext context) {
    width55 = MediaQuery.of(context).size.width;
    height55 = MediaQuery.of(context).size.height;
    _screenUtil = ScreenUtil();
    width = _screenUtil!.screenWidth;
    height = _screenUtil!.screenHeight;
    init(context);
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  static double fromWidth55(double percent) {
    assert(percent >= 0.0 && percent <= 100.0);
    return (percent / 100.0) * width55!;
  }

  static double fromHeight55(double percent) {
    assert(percent >= 0.0 && percent <= 100.0);
    return (percent / 100.0) * height55!;
  }

  static double fromWidth(double percent) {
    assert(percent >= 0.0 && percent <= 100.0);
    return (percent / 100.0) * width;
  }

  static double fromHeight(double percent) {
    assert(percent >= 0.0 && percent <= 100.0);
    return (percent / 100.0) * height;
  }

  static scaleText(double fontSize, {bool? allowFontScalingSelf}) {
    if (_screenUtil == null) return;
    return _screenUtil!.setSp(
      fontSize,
    );
  }
}
