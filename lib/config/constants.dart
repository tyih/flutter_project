class Constants {
  /// 判断当前环境是不是生产环境
  static const bool isRelease =
      bool.fromEnvironment('dart.vm.product', defaultValue: false);

  /// 网络请求配置
  // ignore: constant_identifier_names
  static const String BASE_HOST = isRelease ? 'releasehost.cc' : 'debughose.cc';
  // ignore: constant_identifier_names
  static const String BASE_STATIC_HOST =
      isRelease ? 'http://www.xxx.cn' : 'https://www.xxxx.cn';
  // ignore: constant_identifier_names
  static const String BASE_URL = 'http://$BASE_HOST/app/';

  /// 网络超时配置
  // ignore: constant_identifier_names
  static const int CONNECT_TIMEOUT = isRelease ? 1000 * 30 : 1000 * 50;
  // ignore: constant_identifier_names
  static const int RECEIVE_TIMEOUT = isRelease ? 1000 * 30 : 1000 * 50;
}
