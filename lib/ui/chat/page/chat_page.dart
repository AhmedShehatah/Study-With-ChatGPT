import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_assistant_ai/blocs/chat/cubit/chat_cubit.dart';
import 'package:study_assistant_ai/core/blocs/base_success_state.dart';
import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/data/models/completion_model.dart';
import 'package:study_assistant_ai/models/message.dart';
import 'package:study_assistant_ai/ui/chat/widgets/message_field.dart';

import 'package:grouped_list/grouped_list.dart';
import 'package:study_assistant_ai/ui/chat/widgets/message_widget.dart';

import '../../../blocs/chat/state/chat_state.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = "/chat-page";
  ChatPage({super.key});
  var byMe = 0;
  var byGPT = 0;
  final List<Message> messages = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                bloc: DIManager.findDep<ChatCubit>(),
                listener: (context, state) {
                  var messageState = state.sendMessageState;
                  var completionState = state.completionState;
                  var numberOfQuestions =
                      DIManager.findDep<ChatCubit>().numberOfQuestions;
                  var numberOfAnswers =
                      DIManager.findDep<ChatCubit>().numberOfAnswers;

                  if (messageState is BaseSuccessState) {
                    if (numberOfQuestions != byMe) {
                      messages.add(messageState.data);
                      byMe++;
                    }
                  }
                  if (completionState is BaseSuccessState) {
                    if (numberOfAnswers != byGPT) {
                      var message = (completionState.data as CompletionModel)
                          .choices![0]
                          .text;
                      messages.add(Message(
                          text: message!,
                          isSentByMe: false,
                          date: DateTime.now()));
                      byGPT++;
                    }
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
/*
   var messageState = state.sendMessageState;
                  var completionState = state.completionState;
                  if (messageState is BaseSuccessState) {
                    messages.add(messageState.data);
                  }
                  if (completionState is BaseSuccessState) {
                    var message = (completionState.data as CompletionModel)
                        .choices![0]
                        .text;
                    messages.add(Message(
                        text: message!,
                        isSentByMe: false,
                        date: DateTime.now()));
                  }
*/