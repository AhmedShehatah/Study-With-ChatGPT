import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:study_assistant_ai/core/blocs/base_success_state.dart';
import 'package:study_assistant_ai/models/message.dart';

import '../state/chate_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState.initState());

  void sendMessage(Message message) {
    if (message.text.isNotEmpty) {
      emit(state.copyWith(sendMessageState: BaseSuccessState(message)));
    }
  }
}
