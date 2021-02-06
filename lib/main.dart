import 'package:flutter/material.dart';
import 'routes/home.dart';
import 'theme.dart';
import 'routes/new_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WatchOut',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/new_list': (context) => NewList(),
      },
      theme: watchOutTheme,
    );
  }
}
