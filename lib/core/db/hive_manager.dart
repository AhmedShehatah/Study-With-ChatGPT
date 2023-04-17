import 'package:hive_flutter/hive_flutter.dart';

import '../../models/agenda_model.dart';
import '../../models/note_model.dart';
import '../constansts/hive_boxes_names.dart';

class HiveManager implements IHiveManger {
  late Box<NoteModel> _notes;
  late Box<AgendaModel> _events;
  @override
  void initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());
    Hive.registerAdapter(AgendaModelAdapter());
    _notes = await Hive.openBox(HiveBoxesNames.notes);
    _events = await Hive.openBox(HiveBoxesNames.events);
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

  @override
  void saveToAgenda(AgendaModel event) {
    _events.add(event);
  }

  @override
  List<AgendaModel> getAllEvents() {
    return _events.values.toList();
  }
}

abstract class IHiveManger {
  void initHive();
  void saveNote(NoteModel note);
  List<NoteModel> getAllNotes();
  List<NoteModel> getImportantNotes();
  void saveToAgenda(AgendaModel event);
  List<AgendaModel> getAllEvents();
}
