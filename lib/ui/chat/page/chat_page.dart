import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_assistant_ai/blocs/chat/cubit/chat_cubit.dart';
import 'package:study_assistant_ai/core/constansts/app_consts.dart';
import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/models/message.dart';
import 'package:study_assistant_ai/ui/chat/widgets/message_field.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:study_assistant_ai/ui/chat/widgets/message_widget.dart';

import '../../../blocs/chat/state/chat_state.dart';
import '../../drawer/drawer_over_all.dart';
import '../../drawer/overall_drawer_widget.dart';
import '../widgets/empty_list_widget.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = "/chat-page";
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const OverAllDrawerWidget(drawerTab: OverallDrawerTabs.chat),
        appBar: AppBar(
          // centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(Dimens.appbarBorderRadius),
          )),
          title: const Text(AppConsts.appName),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Do you want to clear chat?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                DIManager.findNavigator().pop();
                              },
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                DIManager.findDep<ChatCubit>().clearMessage();
                                DIManager.findNavigator().pop();
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete_sweep_rounded,
                )),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                bloc: DIManager.findDep<ChatCubit>(),
                builder: (context, state) {
                  if (DIManager.findDep<ChatCubit>().messages.isEmpty) {
                    return const EmptyListWidget();
                  }
                  return GroupedListView<Message, DateTime>(
                    reverse: true,
                    order: GroupedListOrder.DESC,
                    padding: Dimens.textPadding,
                    elements: DIManager.findDep<ChatCubit>().messages,
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
