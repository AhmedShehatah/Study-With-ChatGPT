import 'package:flutter/material.dart';

import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/models/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: _setMessageShape(),
      color: message.isSentByMe ? DIManager.findCC().primaryColor : null,
      child: Padding(
        padding: Dimens.cardInternalPadding,
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isSentByMe ? Colors.white : null,
          ),
        ),
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
}
