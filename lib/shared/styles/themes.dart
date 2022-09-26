import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
ThemeData lightTheme=ThemeData(
  primarySwatch: defaultColor(),
  appBarTheme: AppBarTheme(
    color: defaultColor(),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w700
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 30,
    ),
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:defaultColor(),
      statusBarBrightness: Brightness.light,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed  )
);

ThemeData darkTheme=ThemeData();
