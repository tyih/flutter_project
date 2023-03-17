import 'package:flutter_project/config/apis.dart';
import 'package:flutter_project/model/base_model.dart';
import 'package:flutter_project/model/login_model.dart';
import 'package:flutter_project/services/service_interface.dart';
import 'package:flutter_project/utils/common_util.dart';
import 'package:flutter_project/utils/http_util.dart';

class RequestService implements ServiceInterface {
  /// 内部实例
  static RequestService? _internal;

  /// 工厂构造函数，实现单例
  factory RequestService() {
    _internal ??= RequestService._internal;
    return _internal!;
  }

  /// 命名构造函数，返回类实例
  RequestService.internal();

  @override
  Future<LoginModel?> toLogin(Map<String, String> params) async {
    try {
      final BaseModel res = await HttpUtils().post(Api.login, data: {});
      if (res.code == 0) {
        return LoginModel.fromJson(res.data);
      } else if (res.code == 4001) {
        CommonUtils.showToast(res.msg!);
        throw res.code!;
      }
      return null;
    } catch (e) {
      _handleHttpError(e.toString());
      return null;
    }
  }

  void _handleHttpError(String statusCode) {
    if (statusCode == '500') {
      CommonUtils.showToast('服务器内部错误，无法完成请求');
    } else if (statusCode == '502') {
      CommonUtils.showToast('无效请求');
    } else if (statusCode == '404') {
      CommonUtils.showToast('资源不存在');
    } else if (statusCode == '400') {
      CommonUtils.showToast('客户端语法错误');
    } else {
      CommonUtils.showToast('未知错误');
    }
  }
}
