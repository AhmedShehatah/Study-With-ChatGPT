import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_assistant_ai/models/note_model.dart';
import 'package:study_assistant_ai/repos/notes_repo.dart';

import '../state/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._repo) : super(NotesState.initState());
  final INotesRepo _repo;

  void saveNote(NoteModel note) {
    _repo.saveNote(note);
  }

  List<NoteModel> getAllNotes() => _repo.getAllNotes();
  List<NoteModel> getImportantNotes() => _repo.getImportantNotes();
}
