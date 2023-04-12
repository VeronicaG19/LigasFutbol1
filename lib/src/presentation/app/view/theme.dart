import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final auxilioAppTheme = ThemeData(
    primaryColor: Colors.grey[300],
    textTheme: GoogleFonts.openSansTextTheme(
        const TextTheme(button: TextStyle(color: Colors.grey))),
    // primaryColorDark: const Color(0xFF0097A7),
    appBarTheme: AppBarTheme(
        color: Colors.grey[300],
        iconTheme: const IconThemeData(
          color: Colors.black,
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
        primaryVariant: Colors.white),
    scaffoldBackgroundColor: Colors.grey[200],
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.blueGrey),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blueGrey)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(color: Colors.blueGrey),
        unselectedLabelStyle: TextStyle(color: Colors.blueGrey)));

final darkThemeData = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
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
