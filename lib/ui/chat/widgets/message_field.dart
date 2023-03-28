import 'package:flutter/material.dart';
import 'package:study_assistant_ai/blocs/chat/cubit/chat_cubit.dart';
import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/models/message.dart';

class MessageField extends StatelessWidget {
  MessageField({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(
          vertical: ScreenHelper.fromHeight(2),
          horizontal: ScreenHelper.fromWidth(3)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimens.bigBorderRadius,
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter a message',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: DIManager.findCC().primaryColor,
            ),
            onPressed: () {
              DIManager.findDep<ChatCubit>().sendMessage(Message(
                  text: controller.text,
                  isSentByMe: true,
                  date: DateTime.now()));
              DIManager.findDep<ChatCubit>().createCompletion(
                  model: "text-davinci-003", prompt: controller.text);
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
