import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_assistant_ai/blocs/chat/cubit/chat_cubit.dart';
import 'package:study_assistant_ai/core/blocs/base_loading_state.dart';
import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/models/message.dart';

import '../../../blocs/chat/state/chat_state.dart';

class MessageField extends StatelessWidget {
  final _node = FocusNode();
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
              focusNode: _node,
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
          BlocBuilder<ChatCubit, ChatState>(
            bloc: DIManager.findDep<ChatCubit>(),
            builder: (context, state) {
              var sendingState = state.completionState;
              var isSending = false;
              if (sendingState is BaseLoadingState) {
                isSending = true;
              } else {
                isSending = false;
              }
              return IconButton(
                icon: Icon(
                  Icons.send,
                  color:
                      isSending ? Colors.grey : DIManager.findCC().primaryColor,
                ),
                onPressed: () {
                  if (isSending || controller.text.isEmpty) return;
                  final cubit = DIManager.findDep<ChatCubit>();
                  cubit.sendMessage(
                    Message(
                      text: controller.text.trim(),
                      isSentByMe: true,
                      date: DateTime.now(),
                    ),
                  );

                  cubit.createCompletion(
                      model: "gpt-3.5-turbo", prompt: controller.text.trim());
                  controller.clear();
                  _node.unfocus();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
