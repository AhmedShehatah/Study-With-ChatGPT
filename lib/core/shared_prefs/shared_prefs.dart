import 'package:get_storage/get_storage.dart';

import '../constansts/app_consts.dart';

class SharedPrefs {
  final appLanguageCode = ReadWriteValue(
      'appLanguageCode${AppConsts.appName}', AppConsts.LANG_DEFAULT);
  final firstTime = ReadWriteValue("firstTime${AppConsts.appName}", true);

  final chatRewardedCount =
      ReadWriteValue("chatRewardedCount${AppConsts.appName}", 0);
}
