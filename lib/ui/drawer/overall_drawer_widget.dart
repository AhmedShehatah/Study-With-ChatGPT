import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_header.dart';

import '../../../../core/utils/screen_utils/device_utils.dart';
import '../../core/constansts/dimens.dart';
import 'drawer_over_all.dart';

class OverAllDrawerWidget extends StatelessWidget {
  final OverallDrawerTabs? drawerTab;

  final Null Function()? onCloseDrawer;
  final Null Function()? onOpenDrawer;

  const OverAllDrawerWidget(
      {Key? key,
      required this.drawerTab,
      this.onCloseDrawer,
      this.onOpenDrawer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
          right: Radius.circular(Dimens.cardBorderRadius)),
      child: Container(
        // width: 0.8.sw,
        height: 1.0.sh,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: _buildDrawerPage(),
      ),
    );
  }

  Widget _buildDrawerPage() {
    switch (drawerTab) {
      // case OverallDrawerTabs.Widgets:
      //   return WidgetDrawerContent(onCloseDrawer: onCloseDrawer);
      // case OverallDrawerTabs.Notifications:
      //   return NotificationsDrawerContent(onCloseDrawer: onCloseDrawer);
      //  case OverallDrawerTabs.Profile:
      //   return ProfileDrawerContent(onCloseDrawer: onCloseDrawer,onOpenDrawer: onOpenDrawer,);
      case OverallDrawerTabs.chat:
        return DrawerHeaderWidget(
          onCloseDrawer: onCloseDrawer,
          title: "chat",
        );
      default:
        return SizedBox(
          width: ScreenHelper.width * 0.5,
          child: const Center(
            child: Text(
              'Coming soon',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
    }
  }
}
