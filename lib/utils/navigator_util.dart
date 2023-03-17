import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/router/router_config.dart';

class NavigatorUtils {
  static List<String> accessRoutes = [''];

  /// 不需要页面返回值的跳转
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) async {
    // 隐藏键盘
    FocusScope.of(context).requestFocus(FocusNode());
    if (accessRoutes.contains(path.split('?')[0])) {
      // 需要验证的路由
    }
    RouterConfiger.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native);
  }

  /// 需要页面返回值的跳转
  static pushResult(
      BuildContext context, String path, Function(Object) callBack,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).requestFocus(FocusNode());
    RouterConfiger.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((value) {
      // 页面返回value为null
      if (value == null) {
        return;
      }
      callBack(value);
    }).catchError((error) {
      print("$error");
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context, result);
  }
}
