import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/note_model.dart';
import '../constansts/hive_boxes_names.dart';

class HiveManager implements IHiveManger {
  late Box<NoteModel> _notes;
  @override
  void initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());
    _notes = await Hive.openBox(HiveBoxesNames.notes);
  }

  static void closeHive() async {
    await Hive.close();
  }

  @override
  List<NoteModel> getAllNotes() {
    return _notes.values.toList();
  }

  @override
  void saveNote(NoteModel note) {
    _notes.add(note);
  }

  @override
  List<NoteModel> getImportantNotes() {
    return _notes.values.where((element) => element.isImportant).toList();
  }
}

abstract class IHiveManger {
  void initHive();
  void saveNote(NoteModel note);
  List<NoteModel> getAllNotes();
  List<NoteModel> getImportantNotes();
}
