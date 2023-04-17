import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_assistant_ai/models/agenda_model.dart';

import '../../core/blocs/base_success_state.dart';
import '../../repos/agenda_repo.dart';
import 'agenda_state.dart';

class AgendaCubit extends Cubit<AgendaState> {
  AgendaCubit(this._repo) : super(AgendaState.init());

  final IAgendaRepo _repo;

  List<AgendaModel> getAllEvents() => _repo.getAllEvents();
  void saveToAgenda(AgendaModel event) {
    _repo.saveToAgenda(event);
    emit(state.copyWith(showEventsState: const BaseSuccessState()));
  }

  void refresh() {
    emit(state.copyWith(showEventsState: const BaseSuccessState()));
  }
}
