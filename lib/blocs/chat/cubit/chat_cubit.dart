import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_assistant_ai/core/blocs/base_failure_state.dart';
import 'package:study_assistant_ai/core/blocs/base_loading_state.dart';

import 'package:study_assistant_ai/core/blocs/base_success_state.dart';
import 'package:study_assistant_ai/core/constansts/app_consts.dart';
import 'package:study_assistant_ai/models/message.dart';
import 'package:study_assistant_ai/models/note_model.dart';
import 'package:study_assistant_ai/repos/chatgpt_repo.dart';

import '../state/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._repo) : super(ChatState.initState());
  final IChatGPTRepo _repo;

  List<Message> messages = [];
  void sendMessage(Message message) {
    if (message.text.isNotEmpty) {
      messages.add(message);
      emit(state.copyWith(sendMessageState: BaseSuccessState(message)));
    }
  }

  void clearMessage() {
    messages.clear();
    emit(state.copyWith(sendMessageState: const BaseSuccessState()));
  }

  void createCompletion({required String model, required String prompt}) {
    emit(state.copyWith(completionState: BaseLoadingState()));
    var loadingDots = Message(
      text: AppConsts.jumpingDot,
      isSentByMe: false,
      date: DateTime.now(),
    );
    messages.add(loadingDots);
    _repo.createCompletion(model: model, prompt: prompt).then((response) {
      if (response.hasDataOnly) {
        messages.removeLast();
        var message = Message(
          text: response.data!.choices![0].message!.content!.trim(),
          isSentByMe: false,
          date: DateTime.now(),
        );
        messages.add(message);
        emit(state.copyWith(completionState: BaseSuccessState(response.data)));
      } else {
        messages.removeLast();
        var errorMessage = Message(
            text: "There is an error happened please try again!",
            isSentByMe: false,
            date: DateTime.now());
        messages.add(errorMessage);
        emit(state.copyWith(completionState: BaseFailureState(response.error)));
      }
    });
  }

  void saveToNotes(NoteModel note) {
    _repo.saveNote(note);
  }
}
