import 'package:flutter/material.dart';
import 'package:study_assistant_ai/core/constansts/app_consts.dart';

import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/models/message.dart';
import 'package:jumping_dot/jumping_dot.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: _setMessageShape(),
      color: message.isSentByMe ? DIManager.findCC().primaryColor : null,
      child: InkWell(
        child: Padding(
          padding: Dimens.cardInternalPadding,
          child: (message.text == AppConsts.jumpingDot)
              ? _loadingDots()
              : _messageBody(),
        ),
      ),
    );
  }

  Widget _loadingDots() {
    return SizedBox(
      width: ScreenHelper.fromWidth(12),
      child: JumpingDots(
        color: DIManager.findCC().primaryColor,
        numberOfDots: 3,
        radius: Dimens.dotsRadius,
      ),
    );
  }

  RoundedRectangleBorder _setMessageShape() {
    if (message.isSentByMe) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimens.bigBorderRadius),
        bottomLeft: Radius.circular(Dimens.bigBorderRadius),
        bottomRight: Radius.circular(Dimens.bigBorderRadius),
      ));
    } else {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(Dimens.bigBorderRadius),
        bottomLeft: Radius.circular(Dimens.bigBorderRadius),
        bottomRight: Radius.circular(Dimens.bigBorderRadius),
      ));
    }
  }

  Widget _messageBody() {
    return Text(
      message.text,
      style: TextStyle(
        color: message.isSentByMe ? Colors.white : null,
      ),
    );
  }
}
