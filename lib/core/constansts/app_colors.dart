import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/di/di_manager.dart';
import '../../blocs/application/application_cubit.dart';

class AppColorsController {
  AppColorsController();

  final Rx<Color?> _primaryColor = const Color(0xDDD42B1E).obs;
  String _primaryColorStr = "#EE3E43";

  Color get primaryColor => _primaryColor.value ?? defaultPrimaryColor;

  String get primaryColorStr => _primaryColorStr;

  setPrimaryColor(Color? color) {
    if (color == null) {
      _primaryColor.value = defaultPrimaryColor;
      _primaryColorStr = "#EE3E43";
      DIManager.findDep<ApplicationCubit>().refreshColor();

      return;
    }
    _primaryColorStr = "#${color.toString().split('(0x')[1].split(')')[0]}";
    _primaryColor.value = color;
    DIManager.findDep<ApplicationCubit>().refreshColor();
  }

  void resetPrimaryColor() {
    setPrimaryColor(defaultPrimaryColor);
  }

  void temp() {}

  Color black = Colors.black;
  Color bottomSheetShadow = const Color(0xFF000019);
  Color greyTextColor = const Color(0xFF505050);

  // Color postCountColor = Color(0xFF484747);

  // Color get deactivatedTextColor => greyTextColor.withOpacity(0.6);
  // Color titleTextColor = Color(0xFF6D6D6D);
  Color hintTextColor = const Color(0x6666668D);
  Color greyLightTextColor = const Color(0xFFA6A6A6);
  Color navyBlue = const Color(0xAA033B44);
  Color scaffoldBGColor = Colors.white;

  // Color greyMessageBg = Color(0xFFE9EAEE);
  // Color grey5 = Color(0xFFC9C9C9);
  // Color placeholderBG = Color(0xFFF5F5F5);
  // Color lightBlue = Color(0xff56D8F3);
  // Color blue = Color(0xff11A8F3);
  Color linkBlue = const Color(0xff2072FF);

  // Color favoriteColor = Colors.yellow;
  // Color green = Color(0xFF4CAF50);
  // Color checkInButtonColor = Color(0xFF098D00);
  // Color checkOutButtonColor = Color(0xFFEE3E43);
  // Color dropDownColor = Color(0xFF444444);
  // Color greyIconColor = Color(0xFFC9C9C9);
  // Color taskBG = Color(0xFFFFEEEE);
  //Color brownGrayColor = Color(0xDD707070);
  Color borderTextFieldColor = Colors.grey.withOpacity(0.3);
  Color borderButtonColor = Colors.grey.withOpacity(0.5);

  // Color yellow = Color(0xFFEEBF3F);
  // Color grey = Color(0xFFF3F3F3);
  //
  Color textButtonBackground = const Color(0x00000000);
  Color defaultPrimaryColor = const Color(0xFF8DCA26);

  // Color metroBackgroundPageColor = Color(0xFF471214);
  Color greenProgressColor = const Color(0xff3ec478);

  // Color red = Color(0xFFF44336);
  // Color orange = Color(0xFFFF6600);
  // Color greyIconDarkColor = Color(0xFF707070);
  Color darkGreyTextColor = const Color(0xff1f2630);
  Color blueLightGreyColor = const Color(0xFFf5f7ff);
  // Color greyBackground = Color(0xFFF2F2F2);
  Color notSelectedGrey = const Color(0xFF7A8FA6);
  Color white = Colors.white;
  Color notaryWhite = const Color(0xFFfbfcff);
  Color darkGreyBorderColor = const Color(0xff4f617d);
  Color jeansBlueColor = const Color(0xffecf1f9);
  Color invalidGreyColor = const Color(0xfff2f4f9);
// Color lightGreyBackground = Color(0xffF2F2F2);

// Color emptyIconColor = Color(0xffFFE1E1);
// Color previewLinkBG = Color(0xfff7f7f8);
// Color dividerColor = Color(0xff606060);
// Color sliderColor = Color(0xFF000029);

// static const lightGrey = Color(0xFFFFFFFF);
// static const darkGrey = Color(0xFFFFFFFF);
}
