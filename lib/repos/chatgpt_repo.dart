import 'package:study_assistant_ai/core/db/hive_manager.dart';
import 'package:study_assistant_ai/data/sources/chatpgt_remote_data_source.dart';
import 'package:study_assistant_ai/models/note_model.dart';

import '../core/results/result.dart';
import '../data/models/completion_model.dart';

class ChatGPTRepo implements IChatGPTRepo {
  const ChatGPTRepo(this._chatGPTRemoteDateSource, this._db);
  final IChatGPTRemoteDateSource _chatGPTRemoteDateSource;
  final IHiveManger _db;
  @override
  Future<Result<CompletionModel>> createCompletion(
      {required String model, required String prompt}) async {
    return await _chatGPTRemoteDateSource.createCompletion(
        model: model, prompt: prompt);
  }

  @override
  void saveNote(NoteModel note) {
    _db.saveNote(note);
  }
}

abstract class IChatGPTRepo {
  Future<Result<CompletionModel>> createCompletion(
      {required String model, required String prompt});

  void saveNote(NoteModel note);
}
