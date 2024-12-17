import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.dark, // Enables dark mode
  scaffoldBackgroundColor: Colors.black, // Sets Scaffold background to black
  primarySwatch: Colors.blue, // Primary swatch for button highlights
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black, // AppBar background color
    foregroundColor: Colors.white, // AppBar icons and text color
    elevation: 0, // Removes shadow
  ),
  textTheme: myTextTheme,
  cardColor: Colors.grey[900], // Card background color
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.redAccent, // Button background color
      foregroundColor: Colors.white, // Button text color
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      textStyle: GoogleFonts.poppins(fontSize: 16),
    ),
  ),
);

TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
  displayMedium: GoogleFonts.poppins(
      fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
  displaySmall: GoogleFonts.poppins(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
  headlineLarge: GoogleFonts.poppins(
      fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
  headlineSmall: GoogleFonts.poppins(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
  titleLarge: GoogleFonts.poppins(
      fontSize: 24.0, fontWeight: FontWeight.w500, color: Colors.white),
  titleMedium: GoogleFonts.poppins(
      fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
  titleSmall: GoogleFonts.poppins(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
  bodyLarge: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white),
  bodyMedium: GoogleFonts.poppins(fontSize: 16.0, color: Colors.white),
  bodySmall: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
  labelLarge: GoogleFonts.poppins(
    fontSize: 18.0,
    color: Colors.grey, // Example color
  ),
  labelMedium: GoogleFonts.poppins(
    fontSize: 16.0,
    color: Colors.grey, // Example color
  ),
  labelSmall: GoogleFonts.poppins(
    fontSize: 14.0,
    color: Colors.grey, // Example color
  ),
);
