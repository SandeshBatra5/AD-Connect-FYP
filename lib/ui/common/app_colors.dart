import 'package:flutter/material.dart';

const Color kcPrimaryColor = Color(0xFF3E7C17);
const Color kcPrimaryColorDark = Color(0xFF125C13);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color white = Colors.white;
const Color red = Colors.red;
const Color golden = Color(0xFFF4A442);
const Color lightGolden = Color(0xFFE8E1D9);

Color getColorWithOpacity(Color colors, double val) {
  return colors.withOpacity(val);
}
