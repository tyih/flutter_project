import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/router/route_handlers.dart';

class Routes {
  static String login = '/login';
  static String home = '/home';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const Scaffold(
        body: Center(child: Text('ROUTE WAS NOT FOUND!')),
      );
    });

    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
  }
}
