import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/utils/constants.dart';
import 'package:object_note/core/utils/log_util.dart';
import 'package:object_note/widgets/toast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Http {
  static final Http _instance = Http._internal();

  factory Http() => _instance;

  static late Dio _dio;
  CancelToken cancelToken = CancelToken();
  final String serverDomain = 'https://api.objectnote.top/parse/';

  Http._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: serverDomain,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 5),
        headers: {Constants.headerIdName: Constants.headerId},
        contentType: ContentType.json.toString(),
        responseType: ResponseType.json,
      ),
    );
    _dio.interceptors.add(CustomInterceptor());
    _dio.interceptors.add(PrettyDioLogger(
      request: false,
      // requestBody: true,
      requestHeader: true,
      logPrint: (object) => Log.d(object),
    ));
  }

  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var response = await requestWrapper(
      _dio.get(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken),
    );
    return response.data;
  }

  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var response = await requestWrapper(
      _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
    return response.data;
  }

  Future put(
    String path, {
    required Object data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var response = await requestWrapper(
      _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
    return response.data;
  }

  Future patch(
    String path, {
    required Object data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var response = await requestWrapper(
      _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
    return response.data;
  }

  Future delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var response = await requestWrapper(
      _dio.delete(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
    return response.data;
  }

  Future postForm(
    String path, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var response = await requestWrapper(
      _dio.post(
        path,
        data: FormData.fromMap(data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
    return response.data;
  }

  /// 处理 loading 和 DioError
  Future<Response> requestWrapper(Future<Response> request) {
    Toast.loading();
    Completer<Response> completer = Completer();
    request.then((response) {
      Toast.dismiss();
      completer.complete(response);
      return response;
    }).onError((DioError error, stackTrace) {
      if (error.type != DioErrorType.badResponse) {
        Toast.error(error.message ?? '未知错误');
        Log.d(error);
      }
      completer.future.ignore();
      return Response(requestOptions: RequestOptions());
    });
    return completer.future;
  }

  void cancelRequests({CancelToken? token}) {
    (token ?? cancelToken).cancel('cancelled');
  }
}

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var user = Global.user.value;
    if (user != null) {
      var header = MapEntry(Constants.headerTokenName, user.sessionToken);
      options.headers.addEntries([header]);
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.badResponse) validateStatusError(err);
    super.onError(err, handler);
  }

  void validateStatusError(DioError error) async {
    var httpErrorCode = error.response?.statusCode ?? -1;
    var parseErrorCode = error.response?.data?['code'] ?? '';
    var parseErrorMsg = error.response?.data?['error'] ??
        error.response?.statusMessage ??
        '未知错误';
    Toast.error('$parseErrorMsg\r\n$httpErrorCode$parseErrorCode');
    if (parseErrorCode == '209') {
      Global.onLogout();
    }
  }
}
