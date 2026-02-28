import 'package:dio/dio.dart';
import 'package:demo_ecommerce/app/network/request_header_interceptor.dart';
import 'package:demo_ecommerce/app/core/values/build_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioProvider {
  static final String baseUrl = BuildConfig.instance.envConfig.baseUrl;
  static Dio? _instance;
  static const _maxLineWidth = 90;
  static final _prettyDioLogger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: BuildConfig.instance.environment == Environment.development,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: _maxLineWidth,
  );

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  );

  static Dio get httpDio {
    if (_instance == null) {
      _instance = Dio(_baseOptions);
      _instance!.interceptors.add(_prettyDioLogger);
      return _instance!;
    }
    _instance!.interceptors.clear();
    _instance!.interceptors.add(_prettyDioLogger);
    return _instance!;
  }

  // return access token in header
  static Dio get tokenClient {
    _addInterceptors();

    return _instance!;
  }

  //return access token in header
  //Also adds a token refresh interceptor which retry the request when it's unauthorized
  static Dio get dioWithHeaderToken {
    _addInterceptors();

    return _instance!;
  }

  static _addInterceptors() {
    _instance ??= httpDio;
    _instance!.interceptors.clear();
    _instance!.interceptors.add(RequestHeaderInterceptor());
    _instance!.interceptors.add(_prettyDioLogger);
  }

  static String _buildContentType(String version) {
    return "user_defined_content_type+$version";
  }

  DioProvider.setContentType(String version) {
    _instance?.options.contentType = _buildContentType(version);
  }

  DioProvider.setContentTypeApplicationJson() {
    _instance?.options.contentType = "application/json";
  }
}