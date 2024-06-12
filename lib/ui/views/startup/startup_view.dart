import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/common/app_strings.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:billboard/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
                child: Opacity(
              opacity: 0.1,
              child: ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(kcPrimaryColor, BlendMode.darken),
                  child: Image.asset(
                    'assets/pattern.jpg',
                    fit: BoxFit.cover,
                  )),
            )),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: screenWidthCustom(context, 0.8),
                height: screenHeightCustom(context, 0.6),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 0),
                          spreadRadius: 1,
                          blurRadius: 3,
                          color: kcPrimaryColorDark)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/billborad.json',
                        width: screenWidthCustom(context, 0.5),
                        height: screenWidthCustom(context, 0.5)),
                    text_helper(
                      data: "BILL  BOARD",
                      font: roboto,
                      color: kcDarkGreyColor,
                      size: fontSize30,
                      bold: true,
                    ),
                    text_helper(
                      data: "Accelerate Your Business \nWith Us",
                      font: montserrat,
                      color: kcPrimaryColor,
                      size: fontSize14,
                      bold: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
