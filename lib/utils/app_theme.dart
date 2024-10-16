import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xff5D9CEC);
  static const Color backgroundLight = Color(0xffDFECDB);
  static const Color backgroundDark = Color(0xff060E1E);
  static const Color bottomNavBarDarkColor = Color(0xff141922);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff363636);
  static const Color red = Color(0xffEC4B4B);
  static const Color green = Color(0xff61E757);
  static const Color grey = Color(0xffC8C9CB);
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primary,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: white,
      backgroundColor: primary,
      shape: CircleBorder(
        side: BorderSide(width: 4, color: white),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleMedium: GoogleFonts.poppins(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleSmall: GoogleFonts.poppins(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headlineSmall: GoogleFonts.inter(
        color: black,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundDark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: bottomNavBarDarkColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primary,
      unselectedItemColor: grey,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: white,
      backgroundColor: primary,
      shape: CircleBorder(
        side: BorderSide(width: 4, color: black),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleMedium: GoogleFonts.poppins(
        color: white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleSmall: GoogleFonts.poppins(
        color: white,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headlineSmall: GoogleFonts.inter(
        color: white,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    ),
  );
}
