import 'package:study_assistant_ai/core/blocs/base_init_state.dart';
import 'package:study_assistant_ai/core/blocs/base_state.dart';

class ChatState {
  BaseState sendMessageState;
  BaseState completionState;
  ChatState({
    required this.sendMessageState,
    required this.completionState,
  });

  factory ChatState.initState() => ChatState(
        sendMessageState: const BaseInitState(),
        completionState: const BaseInitState(),
      );

  ChatState copyWith({
    BaseState? sendMessageState,
    BaseState? completionState,
  }) {
    return ChatState(
      sendMessageState: sendMessageState ?? this.sendMessageState,
      completionState: completionState ?? this.completionState,
    );
  }
}
