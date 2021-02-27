import 'package:flutter/material.dart';
import 'package:ecommerce/constants.dart';

/*------------------------------------  Light Theme  ---------------------------------------*/
ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: commonTheme.primaryColor,
  accentColor: commonTheme.accentColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: commonTheme.appBarTheme,
  visualDensity: commonTheme.visualDensity,
  //--**
  // Input Decoration Theme
  //--**
  inputDecorationTheme: commonTheme.inputDecorationTheme.copyWith(
    fillColor: Color(0xFFFCEEDF),
  ),
);

/*------------------------------------  Dark Theme  ---------------------------------------*/
ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: commonTheme.primaryColor,
  accentColor: commonTheme.accentColor,
  appBarTheme: commonTheme.appBarTheme,
  visualDensity: commonTheme.visualDensity,
  scaffoldBackgroundColor: Color(0xFF222327),
  //--**
  // Input Decoration Theme
  //--**
  inputDecorationTheme: commonTheme.inputDecorationTheme.copyWith(
    fillColor: bottomNavColorDark,
  ),
);

/*------------------------------------  Common Theme  ---------------------------------------*/
var commonTheme = ThemeData(
  primaryColor: Color(0xFFF6922D),
  accentColor: Color(0xFFFE3768),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    centerTitle: true,
    elevation: 0.0,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  //--**
  // Input Decoration Theme
  //--**
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: Color(0xFFFE3768), width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: Color(0xFFF6922D), width: 2),
    ),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 15),
  ),
);
