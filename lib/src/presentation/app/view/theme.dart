import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final auxilioAppTheme = ThemeData(
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.black),
      fillColor: MaterialStateProperty.all(Colors.grey[400]),
    ),
    primaryColor: Colors.grey[300],
    textTheme: GoogleFonts.openSansTextTheme(
        const TextTheme(button: TextStyle(color: Colors.grey))),
    // primaryColorDark: const Color(0xFF0097A7),
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.white),
        color: Colors.grey[300],
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 252, 252, 252),
          size: 30,
        ),
        titleTextStyle: const TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic)),

    //primaryColor: Colors.grey,
    colorScheme: const ColorScheme.light(
        onPrimary: Colors.black45,
        onSecondary: Color(0xffB3B6B8),
        secondary: Color(0xffEBECEF),
        primary: Colors.white),
    scaffoldBackgroundColor: Colors.grey[200],
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.blueGrey),
      focusColor: const Color.fromARGB(255, 0, 0, 0),
      floatingLabelStyle: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      activeIndicatorBorder: BorderSide(
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Color.fromARGB(255, 0, 0, 0),
      )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blueGrey)),
    ),
    //tabBarTheme: TabBarTheme(tabAlignment: TabAlignment.center),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(color: Colors.blueGrey),
        unselectedLabelStyle: TextStyle(color: Colors.blueGrey)),
    tabBarTheme: TabBarTheme(dividerColor: Colors.transparent));

final darkThemeData = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
      color: Colors.white24,
      iconTheme: IconThemeData(
        color: Colors.white60,
        size: 30,
      ),
      titleTextStyle: TextStyle(
          fontSize: 17,
          color: Colors.white60,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic)),
  primaryColor: Colors.white24,
  colorScheme: const ColorScheme.dark(
    onPrimary: Colors.white60,
    onSecondary: Colors.white24,
    secondary: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
