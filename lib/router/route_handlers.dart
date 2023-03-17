import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/view/home_page.dart';
import 'package:flutter_project/view/login_page.dart';

Handler loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LoginPage();
});

Handler homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const HomePage();
});
