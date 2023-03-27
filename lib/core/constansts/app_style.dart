import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/di/di_manager.dart';
import '../../../core/utils/screen_utils/device_utils.dart';
import 'app_colors.dart';
import 'app_font.dart';
import 'dimens.dart';

class AppStyle {
  static BoxDecoration formFieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(Dimens.bigBorderRadius),
    boxShadow: [
      BoxShadow(
        spreadRadius: 1,
        blurRadius: 7,
        color: Colors.grey.shade300.withOpacity(0.9),
        offset: const Offset(0.0, 2.5),
      )
    ],
  );

  static BoxDecoration defaultBorderDecoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      border: Border.all(
          color: DIManager.findDep<AppColorsController>().borderTextFieldColor,
          width: 1.w));

  static BoxDecoration greyShadesDecoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      border: Border.all(
          color: DIManager.findDep<AppColorsController>().darkGreyBorderColor,
          width: 1),
      color: DIManager.findDep<AppColorsController>().jeansBlueColor);

  static BoxShadow get iconShadow => BoxShadow(
      offset: const Offset(0, 2.0),
      color: DIManager.findDep<AppColorsController>()
          .primaryColor
          .withOpacity(0.2),
      spreadRadius: 1.0,
      blurRadius: 3.0);

  static BoxShadow coloredShadow(Color color) => BoxShadow(
      offset: const Offset(0, 1),
      color: color,
      spreadRadius: 1.0,
      blurRadius: 1.0);

  static BoxShadow get normalShadow => BoxShadow(
      color: Colors.grey.shade300,
      blurRadius: 4,
      spreadRadius: 1.0,
      offset: const Offset(0, 1));

  static BoxShadow get bottomSheetShadow => BoxShadow(
        color: const Color(0xFF000029).withOpacity(0.15),
        blurRadius: 6,
        spreadRadius: 0,
        offset: const Offset(0, -5),
      );

  static BoxShadow get mediumShadow => BoxShadow(
      color: Colors.grey.shade400,
      blurRadius: 4,
      spreadRadius: 1.0,
      offset: const Offset(0, 1));

  static BoxShadow get normalIconShadow => BoxShadow(
        color: Colors.grey.shade300,
        offset: const Offset(0, 0),
        spreadRadius: 1.5,
        blurRadius: 6.0,
      );

  static InputDecoration inputDecoration(
      {String? hintText,
      String? labelText,
      FocusNode? focusNode,
      Widget? suffixIcon,
      bool? obscuring,
      Color? labelColor,
      Function? onObscurePressed}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 17.w),
      hintStyle: TextStyle(
          fontSize: AppFontSize.fontSize_14,
          color: labelColor ??
              DIManager.findDep<AppColorsController>().hintTextColor),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
          color: focusNode?.hasFocus == true
              ? DIManager.findDep<AppColorsController>().black
              : DIManager.findDep<AppColorsController>().greyTextColor),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: obscuring != null
          ? IconButton(
              icon: Icon(
                obscuring ? Icons.visibility : Icons.visibility_off,
                size: Dimens.iconSize,
                color:
                    DIManager.findDep<AppColorsController>().greyLightTextColor,
              ),
              onPressed: () {
                onObscurePressed!();
              })
          : suffixIcon,
      // border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(Dimens.bigBorderRadius)),
      focusColor: DIManager.findDep<AppColorsController>().borderTextFieldColor,
      focusedBorder: OutlineInputBorder(
        //borderRadius: BorderRadius.circular(Dimens.bigBorderRadius),
        borderSide: BorderSide(
            color:
                DIManager.findDep<AppColorsController>().borderTextFieldColor,
            width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        //borderRadius: BorderRadius.circular(Dimens.bigBorderRadius),
        borderSide: BorderSide(
            width: 1.w,
            color:
                DIManager.findDep<AppColorsController>().borderTextFieldColor),
      ),
      disabledBorder: OutlineInputBorder(
        //  borderRadius: BorderRadius.circular(Dimens.bigBorderRadius),
        borderSide: BorderSide(
            width: 1.w,
            color:
                DIManager.findDep<AppColorsController>().borderTextFieldColor),
      ),
    );
  }

  static InputDecoration inputDecorationSearch({
    String? hintText,
    TextStyle? hintStyle,
    required FocusNode searchFocusNode,
  }) =>
      InputDecoration(
        hintStyle: hintStyle ??
            TextStyle(
                color: DIManager.findDep<AppColorsController>().greyTextColor),
        // hintText: hintText ?? translate('search_here'),
        hintText: 'search here',
        //labelText: labelText,
        focusColor: DIManager.findDep<AppColorsController>().primaryColor,
        hoverColor: DIManager.findDep<AppColorsController>().primaryColor,
        labelStyle: TextStyle(
            color: searchFocusNode.hasFocus == true
                ? DIManager.findDep<AppColorsController>().primaryColor
                : DIManager.findDep<AppColorsController>().greyTextColor),
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.white,
        // contentPadding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
        focusedBorder: InputBorder.none,
        border: InputBorder.none,

        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        //   borderSide: BorderSide(color: Colors.grey),
        // ),
      );

  static InputDecoration inputDecorationOutlined({
    String? hintText,
    String? labelText,
    FocusNode? focusNode,
    Widget? suffixIcon,
    Color? borderColor,
    Color? labelColor,
    double opacity = 1.0,
    double borderSideWidth = 1,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(
        color: labelColor ??
            DIManager.findDep<AppColorsController>().hintTextColor,
        fontWeight: AppFontWeight.bold,
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: focusNode?.hasFocus == true
            ? DIManager.findDep<AppColorsController>().primaryColor
            : labelColor ??
                DIManager.findDep<AppColorsController>()
                    .hintTextColor
                    .withOpacity(opacity),
        fontWeight: AppFontWeight.bold,
      ),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          width: borderSideWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: borderColor != null
              ? borderColor.withOpacity(opacity)
              : Colors.grey.withOpacity(opacity),
          width: borderSideWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: DIManager.findDep<AppColorsController>().primaryColor,
          width: borderSideWidth,
        ),
      ),
    );
  }

  static InputDecoration inputDecorationWithOulLine({
    String? hintText,
    String? labelText,
    FocusNode? focusNode,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(
          color: DIManager.findDep<AppColorsController>().greyTextColor),
      hintText: labelText,
      //labelText: labelText,
      focusColor: DIManager.findDep<AppColorsController>().primaryColor,
      hoverColor: DIManager.findDep<AppColorsController>().primaryColor,
      labelStyle: TextStyle(
          color: focusNode?.hasFocus == true
              ? DIManager.findDep<AppColorsController>().primaryColor
              : DIManager.findDep<AppColorsController>().greyTextColor),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: DIManager.findDep<AppColorsController>().primaryColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: DIManager.findDep<AppColorsController>().primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }

  AppStyle._();

  static String? fontFamily;

  static TextStyle errorMessageStyle = TextStyle(
    fontSize: AppFontSize.fontSize_12,
    color: DIManager.findDep<AppColorsController>().darkGreyTextColor,
    height: 2.0,
  );

  static TextStyle get smallTitleTextStyle => TextStyle(
        fontSize: AppFontSize.fontSize_13,
        color: DIManager.findDep<AppColorsController>().darkGreyTextColor,
      );

  // 10
  static TextStyle lightSubtitle = TextStyle(
    fontSize: AppFontSize.fontSize_10,
    fontWeight: AppFontWeight.light,
    color: DIManager.findDep<AppColorsController>().greyTextColor,
  );

  // 12
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppFontSize.fontSize_12,
        color: DIManager.findDep<AppColorsController>().darkGreyTextColor,
        // height: AppFont.fontHeight,
      );

  // 14
  static TextStyle hintMessageStyle = TextStyle(
    fontSize: AppFontSize.fontSize_14,
    color: DIManager.findDep<AppColorsController>().primaryColor,
    // height: AppFont.fontHeight,
  );
  static TextStyle text14Style = TextStyle(
    fontSize: AppFontSize.fontSize_14,
    color: DIManager.findDep<AppColorsController>().darkGreyTextColor,
    // height: AppFont.fontHeight,
  );
  static TextStyle smallTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_14,
    color: DIManager.findDep<AppColorsController>().darkGreyTextColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle lightGreyText14Style = TextStyle(
    fontSize: AppFontSize.fontSize_14,
    color: DIManager.findDep<AppColorsController>().greyLightTextColor,
    // height: AppFont.fontHeight,
  );

  static TextStyle tabBarLabelStyle = TextStyle(
    fontSize: ScreenHelper.scaleText(51),
    color: DIManager.findDep<AppColorsController>().primaryColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle tabBarUnselectedLabelStyle = TextStyle(
    fontSize: AppFontSize.fontSize_14,
    color: DIManager.findDep<AppColorsController>().greyTextColor,
  );

  static TextStyle appbarStyle = TextStyle(
    fontSize: AppFontSize.fontSize_18,
    color: DIManager.findDep<AppColorsController>().black,
    fontWeight: FontWeight.bold,
  );
  // 16
  static TextStyle titleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_16,
    color: DIManager.findDep<AppColorsController>().darkGreyTextColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    // height: AppFont.fontHeight,
  );
  static TextStyle lightTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_16,
    color: DIManager.findDep<AppColorsController>().darkGreyTextColor,
    fontWeight: AppFontWeight.light,
    letterSpacing: 1,
    // height: AppFont.fontHeight,
  );

  static TextStyle whiteTextOnButton = TextStyle(
    fontSize: AppFontSize.fontSize_16,
    color: DIManager.findDep<AppColorsController>().white,
    fontWeight: AppFontWeight.regular,
    // height: AppFont.fontHeight,
  );
  // 18
  static TextStyle bigTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_18,
    color: DIManager.findDep<AppColorsController>().darkGreyTextColor,
    fontWeight: FontWeight.w700,
  );

  static double get appbarElevation => 4.0;
}
