import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COpy with white color:
final textTheme = ThemeData(
  textTheme: GoogleFonts.nunitoTextTheme()
);

final textThemeWithWhite = textTheme.copyWith(
  textTheme: textTheme.textTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
);