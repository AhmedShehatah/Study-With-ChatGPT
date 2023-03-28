import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:study_assistant_ai/blocs/chat/cubit/chat_cubit.dart';

import '../../blocs/application/application_cubit.dart';

import '../constansts/app_colors.dart';
import '../navigator/app_navigator.dart';
import '../shared_prefs/shared_prefs.dart';

final getIt = GetIt.instance;

class DIManager {
  DIManager._();

  static Future<void> initDI() async {
    _injectDep(ApplicationCubit());
    _injectDep(
      AppNavigator(),
    );
    _injectDep(
      AppColorsController(),
    );

    /// Shared Prefs
    await _setupSharedPreference();

    // firebase

    /// Remotes --------------------------------------------------------------

    /// Repos --------------------------------------------------------------

    /// BLOCs
    _injectDep(ChatCubit());
  }

  static T _injectDep<T extends Object>(T dependency) {
    getIt.registerSingleton<T>(dependency);
    return getIt<T>();
  }

  // ignore: unused_element
  static void _injectDepLazy<T extends Object>(T dependency) {
    getIt.registerLazySingleton<T>(() => dependency);
  }

  // ignore: unused_element
  static Future<void> _injectDepLazyAsync<T extends Object>(
    T dependency,
  ) async {
    getIt.registerLazySingletonAsync<T>(() async => dependency);
    // ignore: avoid_returning_null_for_void
    return null;
  }

  static T findDep<T extends Object>() {
    return getIt<T>();
  }

  static Future<T> findDepAsync<T extends Object>() async {
    return getIt.getAsync<T>();
  }

  static AppNavigator findNavigator() {
    return findDep<AppNavigator>();
  }

  /// It's helper method to retrieve the [AppColorsController] Class
  /// And  {*findCC} equals to FindColorsController
  static AppColorsController findCC() {
    return findDep<AppColorsController>();
  }

  /// It's helper method to retrieve the [ApplicationCubit] Class
  /// And  {*findAC} equals to FindApplicationCubit
  static ApplicationCubit findAC() {
    return findDep<ApplicationCubit>();
  }

  static _setupSharedPreference() async {
    await GetStorage.init();
    _injectDep(SharedPrefs());
  }

  static dispose() {
    findDep<ApplicationCubit>().close();
  }
}
