import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_assistant_ai/core/constansts/app_consts.dart';

import '../../core/constansts/app_colors.dart';
import '../../core/constansts/app_style.dart';
import '../../core/constansts/dimens.dart';
import '../../core/di/di_manager.dart';
import '../../core/utils/screen_utils/device_utils.dart';
import '../../core/utils/ui_utils/horizontal_padding.dart';
import '../../core/utils/ui_utils/vertical_padding.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenHelper.fromHeight(20),
      width: ScreenHelper.width * 0.6,
      color: DIManager.findCC().primaryColor,
      child: Column(
        children: [
          const VerticalPadding(6.0),
          ListTile(
            leading: const Icon(Icons.abc),
            title: Text(
              AppConsts.appName,
              style: AppStyle.titleStyle.copyWith(
                color: DIManager.findDep<AppColorsController>().white,
                fontSize: 20,
              ),
            ),
          ),
          const VerticalPadding(1.5),
        ],
      ),
    );
  }
}
