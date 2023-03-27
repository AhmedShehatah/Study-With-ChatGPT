import 'package:get_storage/get_storage.dart';

import '../constansts/app_consts.dart';

class SharedPrefs {
  final appLanguageCode = ReadWriteValue(
      'appLanguageCode${AppConsts.appName}', AppConsts.LANG_DEFAULT);
}
