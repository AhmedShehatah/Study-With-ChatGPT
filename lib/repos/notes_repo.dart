import 'package:study_assistant_ai/core/db/hive_manager.dart';
import 'package:study_assistant_ai/models/note_model.dart';

class NotesRepo implements INotesRepo {
  NotesRepo(this._db);
  final IHiveManger _db;
  @override
  List<NoteModel> getAllNotes() {
    return _db.getAllNotes();
  }

  @override
  void saveNote(NoteModel note) {
    _db.saveNote(note);
  }
}

abstract class INotesRepo {
  void saveNote(NoteModel note);
  List<NoteModel> getAllNotes();
}
