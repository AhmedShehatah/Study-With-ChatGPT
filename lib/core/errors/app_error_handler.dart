import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:raygun4flutter/raygun4flutter.dart';

class AppErrorHandler {
  static const raygunApiKey = 'drkO6bcCu6NMt1eZCOvQg';

  static void init() {
    Raygun.init(apiKey: raygunApiKey);

    FlutterError.onError = (details) {
      // Default error handling
      FlutterError.presentError(details);
    };
  }

  static void dartErrorCatcher(Function runAppFunction) {
    runZonedGuarded<Future<void>>(() async {
      runAppFunction();
    }, (Object error, StackTrace stackTrace) {
      Logger().d(error);
    });
  }
}
