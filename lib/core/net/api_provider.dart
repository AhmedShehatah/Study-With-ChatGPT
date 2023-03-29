import 'dart:io';

import 'package:dio/dio.dart';

import '../di/di_manager.dart';
import '../errors/base_error.dart';
import '../errors/cancel_error.dart';
import '../errors/custom_error.dart';
import '../errors/net_error.dart';
import '../errors/not_found_error.dart';
import '../errors/time_out_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/unexpected_error.dart';
import '../results/result.dart';
import 'http_method.dart';

class ApiProvider {
  static Future<Result<T>> download<T>({
    required String url,
    ProgressCallback? onProgress,
  }) async {
    try {
      final dio = DIManager.findDep<Dio>();
      Response<T> response = await dio.get<T>(url,
          onReceiveProgress: onProgress,
          options: Options(
            headers: {HttpHeaders.acceptEncodingHeader: "*"},
            responseType: ResponseType.bytes,
          ));

      return Result(data: response.data);
    } on DioError catch (e) {
      return Result(error: _handleDioError(e));
    }
  }

  static Future<Result<T>> sendObjectRequest<T>({
    T Function(dynamic)? converter,
    T Function(List<dynamic>)? converterList,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    FormData? formData,
    bool? dataOnly,
  }) async {
    try {
      // Get the response from the server
      late Response response;
      final dio = DIManager.findDep<Dio>();

      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await dio.post(
            url,
            data: data ?? formData,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await dio.put(
            url,
            data: data ?? formData,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PATCH:
          response = await dio.patch(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
      }

      if (converterList != null) {
        return Result(data: converterList(response.data['data']));
      }
      if (dataOnly == true) {
        return Result(data: converter!(response.data['data']));
      } else {
        return Result(data: converter!(response.data));
      }
    }

    // Handling errors
    on DioError catch (e) {
      return Result(error: _handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (_) {
      return Result(error: CustomError(message: 'Socket Error'));
    } catch (e) {
      return Result(error: CustomError(message: e.toString()));
    }
  }

  static BaseError _handleDioError(DioError error) {
    if (error.type == DioErrorType.unknown ||
        error.type == DioErrorType.badResponse) {
      if (error is SocketException) return NetError();
      if (error.type == DioErrorType.badResponse) {
        switch (error.response!.statusCode) {
          case 401:
            return UnauthorizedError();
          case 400:
          case 404:
            return NotFoundError();
          case 403:
          case 409:
          case 500:
            return NetError();
          default:
            return CustomError();
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.connectionTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return TimeOutError();
    } else if (error.type == DioErrorType.cancel) {
      return CancelError();
    } else {
      return UnExpectedError();
    }
  }
}
