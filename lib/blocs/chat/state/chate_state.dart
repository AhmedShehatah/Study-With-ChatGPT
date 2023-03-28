import 'package:study_assistant_ai/core/blocs/base_init_state.dart';
import 'package:study_assistant_ai/core/blocs/base_state.dart';

class ChatState {
  BaseState sendMessageState;
  ChatState({
    required this.sendMessageState,
  });

  factory ChatState.initState() => ChatState(
        sendMessageState: const BaseInitState(),
      );

  ChatState copyWith({
    BaseState? sendMessageState,
  }) {
    return ChatState(
        sendMessageState: sendMessageState ?? this.sendMessageState);
  }
}
