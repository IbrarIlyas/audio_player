import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color whitecolor = const Color.fromARGB(255, 255, 255, 255);
Color shadowcolor = const Color.fromRGBO(25, 0, 29, 1);
Color color1 = const Color.fromRGBO(107, 1, 146, 0.973);
Color color2 = const Color.fromARGB(255, 89, 2, 121);

TextStyle mystyle({
  FontWeight fontWeight = FontWeight.w600,
  double fontSize = 24,
  Color color_ = Colors.white,
  double letterSpacing = 1,
}) {
  return GoogleFonts.lato(
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: color_,
    letterSpacing: letterSpacing,
  );
}
