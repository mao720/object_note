import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';
import 'package:get/get.dart' as get_x;
import 'package:object_note/core/access_key.dart';
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
      requestBody: true,
      requestHeader: true,
      logPrint: (object) => Log.d(object),
    ));
    Client.init(
      dio: _dio,
      ossEndpoint: "oss-cn-hongkong.aliyuncs.com",
      bucketName: "object-note-oss",
      authGetter: () => const Auth(
          accessKey: AccessKey.accessKeyId,
          accessSecret: AccessKey.accessKeySecret,
          secureToken: "",
          expire: "2822-03-22T11:33:06Z"),
    );
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
    }).onError((DioException error, stackTrace) {
      if (error.type != DioExceptionType.badResponse) {
        Toast.error(error.message ?? 'Unknown Error'.tr);
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

  Future uploadToOSS(String filePath, String name) async {
    final Response resp = await Client().putObjectFile(
      filePath,
      fileKey: Constants.ossDirImage + name,
      option: PutRequestOption(
        onSendProgress: (count, total) {
          Log.d("send: count = $count, and total = $total");
        },
        aclModel: AclMode.inherited,
      ),
    );
    return resp;
  }

  Future uploadToOSSWeb(List<int> intList, String name) async {
    final Response resp = await Client().putObject(
      intList,
      Constants.ossDirImage + name,
      option: PutRequestOption(
        onSendProgress: (count, total) {
          Log.d("send: count = $count, and total = $total");
        },
        aclModel: AclMode.inherited,
      ),
    );
    return resp;
  }
}

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var user = Global.rxUser.value;
    if (user.objectId != null) {
      var header = MapEntry(Constants.headerTokenName, user.sessionToken);
      options.headers.addEntries([header]);
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.badResponse) validateStatusError(err);
    super.onError(err, handler);
  }

  void validateStatusError(DioException error) async {
    Log.d(error);
    var httpErrorCode = error.response?.statusCode ?? -1;
    var parseErrorCode = error.response?.data?['code'] ?? '';
    var parseErrorMsg = error.response?.data?['error'] ??
        error.response?.statusMessage ??
        'Unknown Error'.tr;
    Toast.error('$parseErrorMsg\r\n$httpErrorCode$parseErrorCode');
    if (parseErrorCode == 209) {
      Global.onLogout();
    }
  }
}
