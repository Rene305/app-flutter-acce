import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    //fontFamily: 'Nunito',
    primaryColor: const Color.fromRGBO(68, 88, 159, 1.000),
    appBarTheme: const AppBarTheme(color: Color.fromRGBO(66, 88, 159, 1.000)),
    iconTheme: const IconThemeData(color: Color.fromRGBO(68, 88, 159, 1.000)),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                const Color.fromRGBO(68, 88, 159, 1.000)))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                const Color.fromRGBO(68, 88, 159, 1.000)))),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.nunito(fontSize: 28),
      displayLarge: GoogleFonts.nunito(fontSize: 24, color: Colors.white),
      displayMedium: GoogleFonts.nunito(fontSize: 15, color: Colors.black),
      displaySmall: GoogleFonts.nunito(
          fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData darkTheme =
      ThemeData(brightness: Brightness.dark, fontFamily: 'Nunito');
}
