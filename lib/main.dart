import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'app.dart';
import 'core/errors/app_error_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIManager.initDI();
  MobileAds.instance.initialize();
  AppErrorHandler.dartErrorCatcher(() {
    runApp(const App());
  });
}
