import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/utils/log_util.dart';
import 'package:object_note/widgets/toast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Http {
  static final Http _instance = Http._internal();

  factory Http() => _instance;

  static late Dio _dio;
  CancelToken cancelToken = CancelToken();
  final String serverDomain = 'https://api.objectnote.top/parse/';
  final String headerIdName = 'X-Parse-Application-Id';
  final String headerId = 'object-note-parse-server';
  final String headerTokenName = 'X-Parse-Session-Token';

  Http._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: serverDomain,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 5),
        headers: {headerIdName: headerId},
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
        Toast.error(text: error.message ?? '未知错误');
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
      options.headers
          .addEntries([MapEntry(Http().headerTokenName, user.sessionToken)]);
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.badResponse) validateStatusError(err);
    super.onError(err, handler);
  }

  Map<int, String> errorMap = {
    400: '错误请求',
    401: '没有权限',
    403: '请求被拒绝',
    404: '找不到目标',
    405: '请求方法被禁止',
    500: '服务器内部错误',
    502: '请求被停止',
    503: '服务器关闭',
    505: '协议不支持',
  };

  void validateStatusError(DioError error) {
    int errorCode = error.response?.statusCode ?? -1;
    // String message = errorMap[errorCode] ??
    //     '${error.response?.statusMessage ?? '未知错误'}: $errorCode';
    Toast.error(
      text: '$errorCode${error.response?.data?['code'] ?? ''}'
          '\r\n${error.response?.data?['error'] ?? ''}',
    );
    if (errorCode == 401) {
      //UserStore.to.onLogout();
    }
  }
}
