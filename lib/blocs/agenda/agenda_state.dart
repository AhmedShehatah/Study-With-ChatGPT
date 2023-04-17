import 'package:study_assistant_ai/core/blocs/base_init_state.dart';
import 'package:study_assistant_ai/core/blocs/base_state.dart';

class AgendaState {
  BaseState showEventsState;
  AgendaState({
    required this.showEventsState,
  });
  factory AgendaState.init() => AgendaState(
        showEventsState: const BaseInitState(),
      );
  AgendaState copyWith({
    BaseState? showEventsState,
  }) {
    return AgendaState(
        showEventsState: showEventsState ?? this.showEventsState);
  }
}
