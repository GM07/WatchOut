import 'package:flutter/material.dart';

Color main = Color.fromRGBO(235, 40, 72, 1);
Color contrastBackground = Color.fromRGBO(200, 200, 200, 1);

ThemeData watchOutTheme = ThemeData(
  primaryColor: Colors.red[400],
  backgroundColor: Colors.white,
  splashColor: Colors.red[400],
  scaffoldBackgroundColor: Colors.white,
  dialogBackgroundColor: contrastBackground,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
