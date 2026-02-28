import 'dart:io';
import 'package:dio/dio.dart';
import 'package:demo_ecommerce/app/network/dio_provider.dart';
import 'package:demo_ecommerce/app/network/error_handlers.dart';
import 'package:demo_ecommerce/app/network/exceptions/base_exception.dart';

abstract class BaseRemoteSource {
  Dio get dioClient => DioProvider.httpDio;

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;
      if (response.statusCode != HttpStatus.ok) {
        // Handle non-OK status codes if necessary
      }
      return response;
    } on DioException catch (dioException) {
      Exception exception = handleDioError(dioException);
      throw exception;
    } catch (error) {
      if (error is BaseException) {
        rethrow;
      }
      throw handleGenericError("$error");
    }
  }
}
