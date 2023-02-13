import 'package:dio/dio.dart';
import 'package:object_note/utils/log_util.dart';
import 'package:object_note/utils/pretty_dio_logger.dart';
import 'package:object_note/widgets/toast.dart';

class Http {
  static final Http _instance = Http._internal();

  factory Http() => _instance;

  static late Dio _dio;
  CancelToken cancelToken = CancelToken();
  final String serverDomain = 'https://api.objectnote.top/parse/';
  final String headerName = 'X-Parse-Application-Id';
  final String applicationId = 'object-note-parse-server';

  Http._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: serverDomain,
        // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 5),
        headers: {headerName: applicationId},
        contentType: 'application/json; charset=utf-8',
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(PrettyDioLogger(
      request: false,
      //requestBody: true,
      //requestHeader: true,
      logPrint: (object) => Log.d(object),
    ));

    _dio.interceptors.add(HttpInterceptor());
  }

  /// restful get 操作
  void get(String path,
      {dynamic queryParameters,
      Options? options,
      Function? onSuccess,
      Function? onError}) {
    requestWrapper(
        _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        onSuccess: onSuccess,
        onError: onError);
  }

  /// DioError
  void requestWrapper(Future<Response> request,
      {Function? onSuccess, Function? onError}) {
    Toast.loading();
    request.then((response) {
      Toast.dismiss();
      onSuccess?.call(response.data);
    }).onError((DioError error, stackTrace) {
      Toast.dismiss();
      onError?.call(error);
      if (error.type == DioErrorType.badResponse) return;
      Toast.error(text: error.message ?? '未知错误');
    });
  }

  void cancelRequests({CancelToken? token}) {
    (token ?? cancelToken).cancel('cancelled');
  }

  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    // if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
    //   headers['Authorization'] = 'Bearer ${UserStore.to.token}';
    // }
    return headers;
  }
}

class HttpInterceptor extends Interceptor {
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
    int errorCode = error.response != null ? error.response!.statusCode! : -1;
    String message = errorMap[errorCode] ??
        '${error.response != null ? error.response!.statusMessage! : '未知错误'}: $errorCode';
    Toast.error(text: message);
    if (errorCode == 401) {
      //UserStore.to.onLogout();
    }
  }
}
