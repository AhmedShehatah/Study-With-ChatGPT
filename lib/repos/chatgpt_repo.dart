import 'package:study_assistant_ai/data/sources/chatpgt_remote_data_source.dart';

import '../core/results/result.dart';
import '../data/models/completion_model.dart';

class ChatGPTRepo implements IChatGPTRepo {
  const ChatGPTRepo(this._chatGPTRemoteDateSource);
  final IChatGPTRemoteDateSource _chatGPTRemoteDateSource;
  @override
  Future<Result<CompletionModel>> createCompletion(
      {required String model, required String prompt}) async {
    return await _chatGPTRemoteDateSource.createCompletion(
        model: model, prompt: prompt);
  }
}

abstract class IChatGPTRepo {
  Future<Result<CompletionModel>> createCompletion(
      {required String model, required String prompt});
}
