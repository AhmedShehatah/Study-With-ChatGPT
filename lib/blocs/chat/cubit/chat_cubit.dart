import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_assistant_ai/core/blocs/base_failure_state.dart';
import 'package:study_assistant_ai/core/blocs/base_loading_state.dart';

import 'package:study_assistant_ai/core/blocs/base_success_state.dart';
import 'package:study_assistant_ai/models/message.dart';
import 'package:study_assistant_ai/repos/chatgpt_repo.dart';

import '../state/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._repo) : super(ChatState.initState());
  final IChatGPTRepo _repo;
  var numberOfQuestions = 0;
  var numberOfAnswers = 0;
  void sendMessage(Message message) {
    if (message.text.isNotEmpty) {
      emit(state.copyWith(sendMessageState: BaseSuccessState(message)));
      numberOfQuestions++;
    }
  }

  void createCompletion({required String model, required String prompt}) {
    emit(state.copyWith(completionState: BaseLoadingState()));
    _repo.createCompletion(model: model, prompt: prompt).then((response) {
      if (response.hasDataOnly) {
        emit(state.copyWith(completionState: BaseSuccessState(response.data)));
        numberOfAnswers++;
      } else {
        emit(state.copyWith(completionState: BaseFailureState(response.error)));
      }
    });
  }
}
