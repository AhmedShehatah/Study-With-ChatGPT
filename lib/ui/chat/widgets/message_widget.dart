import 'package:flutter/material.dart';
import 'package:study_assistant_ai/blocs/notes/cubit/notes_cubit.dart';
import 'package:study_assistant_ai/core/constansts/app_consts.dart';

import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/core/utils/ui_utils/custom_snack_bar.dart';
import 'package:study_assistant_ai/models/message.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:koukicons_jw/save.dart';
import 'package:koukicons_jw/share2.dart';
import 'package:study_assistant_ai/models/note_model.dart';

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
        child: (message.text == AppConsts.jumpingDot)
            ? _loadingDots()
            : _messageBody(context),
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

  Widget _messageBody(BuildContext context) {
    return message.isSentByMe ? _userMessage() : _botMessage(context);
  }

  Widget _userMessage() {
    return Text(
      message.text,
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _botMessage(BuildContext context) {
    return InkWell(
      child: Text(message.text),
      onTap: () {
        showDialog(
            context: context,
            builder: (cxt) {
              return Dialog(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  InkWell(
                    child: ListTile(
                      title: const Text("Save To Notes"),
                      leading: KoukiconsSave(height: Dimens.iconSize),
                    ),
                    onTap: () {
                      DIManager.findDep<NotesCubit>().saveNote(NoteModel(
                          id: 0,
                          title: "No Title",
                          body: message.text,
                          creationDate: DateTime.now()));
                      DIManager.findNavigator().pop();
                      CustomSnackbar.showSnackbar("Saved");
                    },
                  ),
                  ListTile(
                    title: const Text("Share"),
                    leading: KoukiconsShare2(height: Dimens.iconSize),
                  )
                ]),
              );
            });
      },
    );
  }
}
