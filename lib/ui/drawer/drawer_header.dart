import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constansts/app_colors.dart';
import '../../core/constansts/app_style.dart';
import '../../core/constansts/dimens.dart';
import '../../core/di/di_manager.dart';
import '../../core/utils/ui_utils/horizontal_padding.dart';
import '../../core/utils/ui_utils/vertical_padding.dart';

class DrawerHeaderWidget extends StatelessWidget {
  final String? title;
  final Function()? onCloseDrawer;
  final Widget? child;
  final double? horizontalPadding;

  const DrawerHeaderWidget({
    Key? key,
    this.title,
    required this.onCloseDrawer,
    this.child,
    this.horizontalPadding,
  }) : super(key: key);

  const DrawerHeaderWidget.withOutDivider({
    Key? key,
    this.title,
    required this.onCloseDrawer,
    required Widget this.child,
    this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalPadding(6.0),
        Padding(
          padding: Dimens.defaultPageHorizontalPaddingSmall,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (horizontalPadding != null)
                HorizontalPadding(horizontalPadding!),
              Text(
                title!,
                style: AppStyle.titleStyle.copyWith(
                    color: DIManager.findDep<AppColorsController>()
                        .darkGreyTextColor),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  onCloseDrawer!();
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 0.05.sw,
                  color: DIManager.findDep<AppColorsController>().primaryColor,
                ),
              )
            ],
          ),
        ),
        const VerticalPadding(1.5),
        if (child == null)
          Divider(
            thickness: 1.0,
            color: DIManager.findDep<AppColorsController>()
                .greyLightTextColor
                .withOpacity(0.5),
          ),
        if (child != null) child!,
        const VerticalPadding(1.5),
      ],
    );
  }
}
