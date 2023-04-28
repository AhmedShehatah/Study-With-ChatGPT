import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:study_assistant_ai/blocs/chat/cubit/chat_cubit.dart';
import 'package:study_assistant_ai/core/ads/ads_manager.dart';
import 'package:study_assistant_ai/core/blocs/base_loading_state.dart';
import 'package:study_assistant_ai/core/constansts/app_font.dart';
import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/shared_prefs/shared_prefs.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/core/utils/ui_utils/custom_snack_bar.dart';
import 'package:study_assistant_ai/models/message.dart';

import '../../../blocs/chat/state/chat_state.dart';

class MessageField extends StatefulWidget {
  const MessageField({super.key});

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final _node = FocusNode();

  final TextEditingController controller = TextEditingController();

  var isSending = false;

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
                onPressed: _pressSend,
              );
            },
          ),
        ],
      ),
    );
  }

  void _pressSend() {
    if (isSending || controller.text.isEmpty) return;

    var countOfMessages =
        DIManager.findDep<SharedPrefs>().chatRewardedCount.val;

    if (countOfMessages != 0 && countOfMessages % 3 == 0) {
      showCustomDialog();
    } else {
      final cubit = DIManager.findDep<ChatCubit>();
      cubit.sendMessage(
        Message(
          text: controller.text.trim(),
          isSentByMe: true,
          date: DateTime.now(),
        ),
      );
      DIManager.findDep<SharedPrefs>().chatRewardedCount.val++;
      cubit.createCompletion(
          model: "gpt-3.5-turbo", prompt: controller.text.trim());
      controller.clear();
      _node.unfocus();
    }
  }

  void showCustomDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            title: Text(
              "You Have Reached the maximum number of messages",
              style: TextStyle(fontSize: AppFontSize.fontSize_14),
            ),
            content: const Text("Watch Ad to get more messages."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  var pd = ProgressDialog(context, isDismissible: false);
                  pd.show();
                  AdsManger.loadRewardedAd().then((rewardAd) {
                    if (rewardAd != null) {
                      pd.hide();
                      rewardAd.show(
                        onUserEarnedReward: (ad, rewardedItem) {
                          DIManager.findDep<SharedPrefs>()
                              .chatRewardedCount
                              .val = 0;
                          DIManager.findNavigator().pop();
                        },
                      );
                    } else {
                      pd.hide();
                      CustomSnackbar.showSnackbar("Can't load Ad try again!");
                    }
                  });
                },
                child: const Text("Watch Ad!"),
              )
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        },
      ),
    );
  }
}
