import 'package:calculadora/src/pages/calculadora_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color.fromRGBO(211, 211, 210, 0.0),
    ));
    return MaterialApp(
      title: 'Calculadora App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => CalculadoraPage(),
      },
    );
  }
}
