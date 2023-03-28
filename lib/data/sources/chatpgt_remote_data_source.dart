import 'package:logger/logger.dart';
import 'package:study_assistant_ai/core/data_source/base_remote_data_source.dart';
import 'package:study_assistant_ai/core/net/http_method.dart';
import 'package:study_assistant_ai/core/results/result.dart';
import 'package:study_assistant_ai/data/endpoints/endpoints.dart';
import 'package:study_assistant_ai/data/models/completion_model.dart';

class ChatGPTRemoteDataSource implements IChatGPTRemoteDateSource {
  const ChatGPTRemoteDataSource();

  @override
  Future<Result<CompletionModel>> createCompletion(
      {required String model, required String prompt}) async {
    Logger().d(model);
    return await RemoteDataSource.request<CompletionModel>(
      converter: (model) => CompletionModel.fromJson(model),
      method: HttpMethod.POST,
      url: AppEndpoints.completion,
      data: {
        "model": model,
        "prompt": prompt,
        "max_tokens": 2048,
      },
    );
  }
}

abstract class IChatGPTRemoteDateSource {
  Future<Result<CompletionModel>> createCompletion(
      {required String model, required String prompt});
}
