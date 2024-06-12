// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../ui_helpers.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show_snackbar(
    BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: GoogleFonts.poppins(),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

Widget displaysimpleprogress(BuildContext context) {
  return Center(
    child: SizedBox(
        width: screenWidthCustom(context, 0.3),
        height: screenWidthCustom(context, 0.3),
        child: Lottie.asset('assets/billborad.json')),
  );
}

void displayprogress(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: SizedBox(
              width: screenWidthCustom(context, 0.3),
              height: screenWidthCustom(context, 0.3),
              child: Lottie.asset('assets/billborad.json')),
        ),
      );
    },
  );
}

void hideprogress(BuildContext context) {
  Navigator.pop(context);
}
