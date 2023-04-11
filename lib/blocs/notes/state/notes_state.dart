import 'package:study_assistant_ai/core/blocs/base_init_state.dart';

import '../../../core/blocs/base_state.dart';

class NotesState {
  BaseState saveNoteState;
  BaseState showNotesState;
  BaseState showImportantNotesState;

  NotesState({
    required this.saveNoteState,
    required this.showImportantNotesState,
    required this.showNotesState,
  });
  factory NotesState.initState() => NotesState(
        saveNoteState: const BaseInitState(),
        showImportantNotesState: const BaseInitState(),
        showNotesState: const BaseInitState(),
      );

  NotesState copyWith({
    BaseState? saveNoteState,
    BaseState? showNotesState,
    BaseState? showImportantNotesState,
  }) {
    return NotesState(
        saveNoteState: saveNoteState ?? this.saveNoteState,
        showImportantNotesState: showImportantNotesState ?? this.saveNoteState,
        showNotesState: showNotesState ?? this.showNotesState);
  }
}
