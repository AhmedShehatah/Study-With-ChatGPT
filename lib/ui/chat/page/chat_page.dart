import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_assistant_ai/blocs/chat/cubit/chat_cubit.dart';
import 'package:study_assistant_ai/core/blocs/base_success_state.dart';
import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/models/message.dart';
import 'package:study_assistant_ai/ui/chat/widgets/message_field.dart';

import 'package:grouped_list/grouped_list.dart';
import 'package:study_assistant_ai/ui/chat/widgets/message_widget.dart';

import '../../../blocs/chat/state/chate_state.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = "/chat-page";
  ChatPage({super.key});
  final List<Message> messages = [
    Message(text: "text", date: DateTime.now(), isSentByMe: true),
    Message(text: "text2", date: DateTime.now(), isSentByMe: false),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                bloc: DIManager.findDep<ChatCubit>(),
                listenWhen: (s0, s1) =>
                    s0.sendMessageState != s1.sendMessageState,
                buildWhen: (s0, s1) =>
                    s0.sendMessageState != s1.sendMessageState,
                listener: (context, state) {
                  var messageState = state.sendMessageState;
                  if (messageState is BaseSuccessState) {
                    messages.add(messageState.data);
                  }
                },
                builder: (context, state) {
                  return GroupedListView<Message, DateTime>(
                    reverse: true,
                    order: GroupedListOrder.DESC,
                    padding: Dimens.textPadding,
                    elements: messages,
                    groupBy: (message) => DateTime(
                      message.date.year,
                      message.date.month,
                      message.date.day,
                    ),
                    groupHeaderBuilder: (element) => const SizedBox(),
                    itemBuilder: (context, message) {
                      return Align(
                        alignment: message.isSentByMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: MessageWidget(
                          message: message,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            MessageField(),
          ],
        ),
      ),
    );
  }
}
