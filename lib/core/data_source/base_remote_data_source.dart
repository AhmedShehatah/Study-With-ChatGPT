import 'package:dio/dio.dart';
import 'package:study_assistant_ai/core/constansts/app_consts.dart';

import '../../../core/results/result.dart';
import '../net/api_provider.dart';
import '../net/http_method.dart';

abstract class RemoteDataSource {
  static Future<Result<MODEL>> request<MODEL>(
      {MODEL Function(dynamic)? converter,
      MODEL Function(List<dynamic>?)? converterList,
      required HttpMethod method,
      required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      bool listRequest = false,
      CancelToken? cancelToken,
      FormData? formData,
      bool? dataOnly,
      bool? reqiureToken}) async {
    headers ??= {};

    headers['Authorization'] = "Bearer ${AppConsts.chatGPTToken}";
    headers['Content-Type'] = "application/json";

    return await ApiProvider.sendObjectRequest<MODEL>(
      converter: converter,
      converterList: converterList,
      method: method,
      url: url,
      data: data,
      headers: headers,
      dataOnly: dataOnly,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      formData: formData,
    );
  }
}
