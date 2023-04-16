import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:study_assistant_ai/core/db/hive_manager.dart';
import 'package:study_assistant_ai/core/shared_prefs/shared_prefs.dart';
import 'package:study_assistant_ai/ui/chat/page/chat_page.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_over_all.dart';
import 'package:study_assistant_ai/ui/intro_screen/intro_screen.dart';

import 'blocs/application/application_cubit.dart';
import 'blocs/application/application_state.dart';
import 'core/constansts/app_colors.dart';
import 'core/constansts/app_consts.dart';
import 'core/di/di_manager.dart';
import 'core/navigator/route_generator.dart';
import 'core/utils/screen_utils/device_utils.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: BlocProvider<ApplicationCubit>(
        create: (context) => ApplicationCubit(),
        child: ScreenUtilInit(
          designSize: const Size(376, 812),
          builder: (context, _) {
            return BlocConsumer<ApplicationCubit, ApplicationState>(
              listener: (_, __) {},
              buildWhen: (s0, s1) {
                return false;
              },
              listenWhen: (s0, s1) {
                return false;
              },
              builder: (context, state) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  enableLog: false,
                  onGenerateRoute: RouteGenerator.generateRoutes,
                  builder: ((context, widget) {
                    ScreenHelper(context);
                    return DrawerOverAllWidget(child: widget);
                  }),
                  theme: ThemeData(
                      brightness: Brightness.dark,
                      // Making Roboto Regular the default font for Project
                      fontFamily: 'Roboto',
                      primaryColor:
                          DIManager.findDep<AppColorsController>().primaryColor,
                      colorScheme: const ColorScheme.dark()
                          .copyWith(
                              primary: DIManager.findDep<AppColorsController>()
                                  .primaryColor)
                          .copyWith(
                              secondary:
                                  DIManager.findDep<AppColorsController>()
                                      .primaryColor)),
                  title: AppConsts.appName,
                  initialRoute: (DIManager.findDep<SharedPrefs>().firstTime.val)
                      ? IntroScreen.routeName
                      : ChatPage.routeName,
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    DIManager.findAC().init();
  }

  @override
  void dispose() {
    HiveManager.closeHive();
    DIManager.dispose();
    super.dispose();
  }
}
