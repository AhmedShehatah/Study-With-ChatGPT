import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigator {
  GlobalKey<NavigatorState> get navigationKey => Get.key;

  Future<T?> pushNamed<T>(String routeName, {dynamic arguments}) {
    return navigationKey.currentState!
        .pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T>(String routeName, {dynamic arguments}) {
    return navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<T?> pushNamedAndRemoveUntil<T>(String routeName) {
    return navigationKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  void pop<T>([T? result]) {
    return navigationKey.currentState!.pop(result);
  }

  bool canPop() {
    return navigationKey.currentState!.canPop();
  }

  Future<T?> offAll<T>(String routeName, {dynamic arguments, T? result}) {
    return navigationKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
    );
  }
}
