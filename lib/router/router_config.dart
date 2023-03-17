import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class RouterConfiger {
  /// 全局context
  static GlobalKey<NavigatorState> navigatorState = GlobalKey();

  /// 全局路由对象
  static late FluroRouter router;
}
