import 'package:flutter/material.dart';

import '../../../../../core/utils/screen_utils/device_utils.dart';

class VerticalPadding extends StatelessWidget {
  final double percentage;

  const VerticalPadding(this.percentage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: ScreenHelper.fromHeight55(percentage));
  }
}
