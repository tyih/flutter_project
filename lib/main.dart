import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project/common/global.dart';
import 'package:flutter_project/router/router_config.dart';
import 'package:flutter_project/theme/theme_dark.dart';
import 'package:flutter_project/theme/theme_light.dart';
import 'generated/l10n.dart';

void main() => Global.init().then((e) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateTitle: (context) => S.of(context).app_title,
        theme: lightTheme,
        darkTheme: darkTheme,
        navigatorKey: RouterConfiger.navigatorState,
        onGenerateRoute: RouterConfiger.router.generator,
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).main_title), // 主标题翻译
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const Icon(Icons.favorite),
            Theme(
                data: Theme.of(context).copyWith(
                    iconTheme: const IconThemeData(color: Colors.green)),
                child: const Icon(Icons.feedback)),
            Text(
              S.of(context).message_tip(_counter.toString()),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
