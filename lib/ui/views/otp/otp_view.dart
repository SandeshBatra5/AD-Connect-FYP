// ignore_for_file: must_be_immutable

import 'package:billboard/ui/widgets/common/top/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';

import 'package:pinput/pinput.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import '../../common/uihelper/button_helper.dart';
import '../../common/uihelper/text_helper.dart';
import 'otp_viewmodel.dart';

class OtpView extends StackedView<OtpViewModel> {
  OtpView({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  Widget builder(
    BuildContext context,
    OtpViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Top(txt: "OTP"),
            Padding(
              padding: const EdgeInsetsDirectional.all(15),
              child: Pinput(
                length: 6,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                controller: viewModel.otp,
              ).animate(delay: 500.milliseconds).fade(),
            ),
            button_helper(
                    onpress: () => viewModel.next(context),
                    color: kcPrimaryColor,
                    width: screenWidthCustom(context, 0.3),
                    raduis: 20,
                    padding: const EdgeInsetsDirectional.all(8),
                    child: text_helper(
                      data: "next",
                      font: poppins,
                      color: white,
                      size: fontSize18,
                      bold: true,
                    ))
                .animate(delay: 500.milliseconds)
                .fade()
                .moveY(begin: 50, end: 0),
          ],
        ),
      ),
    );
  }

  @override
  void onDispose(OtpViewModel viewModel) {
    viewModel.otp.dispose();
  }

  @override
  void onViewModelReady(OtpViewModel viewModel) {
    viewModel.first(id);
  }

  @override
  OtpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OtpViewModel();
}
