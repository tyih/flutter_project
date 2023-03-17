import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_project/config/constants.dart';
import 'package:flutter_project/model/base_model.dart';
import 'package:flutter_project/router/router_config.dart';
import 'package:flutter_project/utils/common_util.dart';
import 'package:flutter_project/utils/navigator_util.dart';
import 'package:flutter_project/utils/shared_preferences_util.dart';

enum Method { get, post, put, patch, delete }

class HttpUtils {
  static Dio? _dio;

  /// 构造单例
  HttpUtils() {
    _dio ??= getInstance();
  }

  /// 创建dio实例
  static Dio? getInstance() {
    if (_dio == null) {
      BaseOptions baseOptions = BaseOptions(
          baseUrl: Constants.BASE_URL,
          connectTimeout:
              const Duration(milliseconds: Constants.CONNECT_TIMEOUT),
          receiveTimeout:
              const Duration(milliseconds: Constants.RECEIVE_TIMEOUT),
          headers: {'Content-Type': 'application/json'});
      _dio = Dio(baseOptions);
      _dio!.interceptors.add(InterceptorsWrapper(onRequest:
          (RequestOptions requestOptions,
              RequestInterceptorHandler handler) async {
        requestOptions.contentType =
            requestOptions.contentType ?? 'application/json';
        // 请求拦截，加入token
        String token = SpUtil.getString("token");
        Map<String, String> headers = {"token": token};
        requestOptions.headers = headers;
        handler.next(requestOptions);
      }, onResponse: (response, handler) {
        if (response.statusCode == HttpStatus.unauthorized) {
          SpUtil.clear();
          // token失效，重定向到登录页
          NavigatorUtils.push(
              RouterConfiger.navigatorState.currentContext!, '/enter/login',
              clearStack: true);
        }
        handler.next(response);
      }, onError: (error, handler) {
        if (error.response?.statusCode == HttpStatus.unauthorized ||
            error.response?.statusCode == HttpStatus.forbidden) {
          SpUtil.clear();
        }
        handler.reject(error);
      }));
    }
    return _dio;
  }

  /// 清除dio对象
  static clear() {
    _dio = null;
  }

  Future<BaseModel> get(String url, {data}) async {
    return _request(url, method: Method.get, data: data);
  }

  Future<BaseModel> post(String url, {data}) async {
    return _request(url, method: Method.post, data: data);
  }

  Future<BaseModel> put(String url, {data}) async {
    return _request(url, method: Method.put, data: data);
  }

  Future<BaseModel> patch(String url, {data}) async {
    return _request(url, method: Method.patch, data: data);
  }

  Future<BaseModel> delete(String url, {data}) async {
    return _request(url, method: Method.delete, data: data);
  }

  Future<BaseModel> _request(String url, {required Method method, data}) async {
    try {
      Response response;
      switch (method) {
        case Method.get:
          Options options = Options(method: 'get');
          response =
              await _dio!.get(url, queryParameters: data, options: options);
          break;
        case Method.post:
          Options options = Options(method: 'post');
          response = await _dio!.post(url, data: data, options: options);
          break;
        case Method.put:
          Options options = Options(method: 'put');
          response = await _dio!.put(url, data: data, options: options);
          break;
        case Method.patch:
          Options options = Options(method: 'patch');
          response = await _dio!.patch(url, data: data, options: options);
          break;
        case Method.delete:
          Options options = Options(method: 'delete');
          response =
              await _dio!.delete(url, queryParameters: data, options: options);
          break;
      }
      // 打印响应日志
      _printLog(response);
      BaseModel baseModel = BaseModel.fromJson(response.data);
      if (baseModel.httpStatus == HttpStatus.ok) {
        if (baseModel.code == 401) {
          CommonUtils.showToast('会话失效，请重新登录');
          throw (DioError(requestOptions: response.requestOptions));
        } else {
          return baseModel;
        }
      } else {
        // 完成通信，HttpStatus错误，需要抛给业务层解决
        throw baseModel.httpStatus ?? 500;
      }
    } on DioError catch (e) {
      _handleError(e);
      throw e;
    }
  }

  void _printLog(Response response) {
    if (Constants.isRelease) {
      return;
    }
    print('----------------HTTP LOG START-------------------');
    try {
      print('[statusCode]: ${response.statusCode.toString()}');
      print(
          '[request]: method = ${response.requestOptions.method}, baseUrl = ${response.requestOptions.baseUrl}');
      print('[requestData]: ${response.requestOptions.data.toString()}');
      print('[responseData]: ${response.data.toString()}');
    } catch (e) {
      print('Http log error: $e');
    }
    print('----------------HTTP LOG END-------------------');
  }

  /// error统一处理
  static void _handleError(DioError e) {
    print('###################### Error: ${e.toString()}');
    if (e.type == DioErrorType.connectionError) {
      CommonUtils.showToast('连接超时');
    } else if (e.type == DioErrorType.sendTimeout) {
      CommonUtils.showToast('请求超时');
    } else if (e.type == DioErrorType.receiveTimeout) {
      CommonUtils.showToast('响应超时');
    } else if (e.type == DioErrorType.badResponse) {
      CommonUtils.showToast('无法访问服务器，请稍后再试');
    } else if (e.type == DioErrorType.cancel) {
      CommonUtils.showToast('请求取消');
    } else {
      CommonUtils.showToast('未知错误');
    }
    print('error message: ${e.message}');
  }
}
