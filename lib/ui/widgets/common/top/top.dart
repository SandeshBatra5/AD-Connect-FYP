// ignore_for_file: must_be_immutable

import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/common/app_strings.dart';
import 'package:billboard/ui/common/ui_helpers.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import 'top_model.dart';

class Top extends StackedView<TopModel> {
  Top({super.key, required this.txt});
  String txt;

  @override
  Widget builder(
    BuildContext context,
    TopModel viewModel,
    Widget? child,
  ) {
    return Container(
      width: screenWidth(context),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: white,
      ),
      child: Row(
        children: [
          Lottie.asset('assets/billborad.json',
              width: screenWidthCustom(context, 0.15),
              height: screenWidthCustom(context, 0.15)),
          text_helper(
            data: txt,
            font: montserrat,
            color: kcDarkGreyColor,
            size: fontSize22,
            bold: true,
          )
        ],
      ),
    );
  }

  @override
  TopModel viewModelBuilder(
    BuildContext context,
  ) =>
      TopModel();
}
