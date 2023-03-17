import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/router/router_config.dart';
import 'package:flutter_project/router/routes.dart';

class Global {
  /// 初始化全局信息，App启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 个人信息

    // 主题

    // 设置缓存策略

    // 网络请求配置

    // 沉浸式状态栏
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    // 路由配置
    final router = FluroRouter();
    Routes.configureRoutes(router);
    RouterConfiger.router = router;
  }
}
