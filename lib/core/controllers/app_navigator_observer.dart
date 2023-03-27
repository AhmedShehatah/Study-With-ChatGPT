import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:study_assistant_ai/ui/chat/page/chat_page.dart';

import '../../blocs/application/application_cubit.dart';
import '../di/di_manager.dart';

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == ChatPage.routeName) {
      DIManager.findDep<ApplicationCubit>().setSideDrawer(false);
    } else {
      DIManager.findDep<ApplicationCubit>().setSideDrawer(true);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == ChatPage.routeName
        //  route.settings.name == AppBottomSheet.routeNameSecondLevel ||
        //  route is SnackRoute ||
        // route.settings.name == SelectWorkplacePage.routeName ||

        // ||
        // (previousRoute.settings.name == SignInPage.routeName
        // && route is SnackRoute
        // )

        ) {
      DIManager.findDep<ApplicationCubit>().setSideDrawer(false);
    } else {
      DIManager.findDep<ApplicationCubit>().setSideDrawer(true);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
  }
}
