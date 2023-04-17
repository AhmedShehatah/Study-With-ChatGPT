import 'package:study_assistant_ai/core/db/hive_manager.dart';

import '../models/agenda_model.dart';

class AgendaRepo implements IAgendaRepo {
  final IHiveManger _db;
  AgendaRepo(this._db);
  @override
  List<AgendaModel> getAllEvents() {
    return _db.getAllEvents();
  }

  @override
  void saveToAgenda(AgendaModel event) {
    _db.saveToAgenda(event);
  }
}

abstract class IAgendaRepo {
  void saveToAgenda(AgendaModel event);
  List<AgendaModel> getAllEvents();
}
