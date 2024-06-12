// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_strings.dart';
import '../../../common/ui_helpers.dart';
import '../../../common/uihelper/text_helper.dart';
import 'tophelper_model.dart';

class Tophelper extends StackedView<TophelperModel> {
  Tophelper(
      {super.key,
      required this.function,
      required this.icon,
      required this.txt});
  Function function;
  IconData icon;
  String txt;

  @override
  Widget builder(
    BuildContext context,
    TophelperModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        width: screenWidth(context),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kcPrimaryColor,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: white,
              weight: 10,
              size: screenWidthCustom(context, 0.05),
            ),
            horizontalSpaceSmall,
            text_helper(
                data: txt,
                bold: true,
                font: poppins,
                color: white,
                size: fontSize14),
          ],
        ),
      ),
    );
  }

  @override
  TophelperModel viewModelBuilder(
    BuildContext context,
  ) =>
      TophelperModel();
}
