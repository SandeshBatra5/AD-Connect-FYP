import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/common/app_strings.dart';
import 'package:billboard/ui/common/uihelper/button_helper.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:billboard/ui/widgets/common/top/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:stacked/stacked.dart';

import '../../common/ui_helpers.dart';
import 'sigin_viewmodel.dart';

class SiginView extends StackedView<SiginViewModel> {
  const SiginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SiginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Top(txt: "Category"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipPath(
                clipper: RoundedDiagonalPathClipper(),
                child: Container(
                  height: screenHeightCustom(context, 0.7),
                  width: screenWidth(context),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    color: getColorWithOpacity(kcPrimaryColor, 0.6),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      button_helper(
                              onpress: () => viewModel.billboard(),
                              color: white,
                              width: screenWidthCustom(context, 0.4),
                              raduis: 30,
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/billboard.png",
                                    width: screenWidthCustom(context, 0.2),
                                    height: screenHeightCustom(context, 0.2),
                                  ),
                                  text_helper(
                                      data: "Bill Board",
                                      font: poppins,
                                      bold: true,
                                      color: kcDarkGreyColor,
                                      size: fontSize18)
                                ],
                              ))
                          .animate(delay: 700.milliseconds)
                          .fade()
                          .moveY(begin: 50, end: 0),
                      button_helper(
                              onpress: () => viewModel.user(),
                              color: white,
                              width: screenWidthCustom(context, 0.4),
                              raduis: 30,
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/person.png",
                                    width: screenWidthCustom(context, 0.2),
                                    height: screenHeightCustom(context, 0.2),
                                  ),
                                  text_helper(
                                    data: "User",
                                    font: poppins,
                                    color: kcDarkGreyColor,
                                    size: fontSize18,
                                    bold: true,
                                  )
                                ],
                              ))
                          .animate(delay: 900.milliseconds)
                          .fade()
                          .moveY(begin: 50, end: 0),
                    ],
                  ),
                ),
              ),
            ).animate(delay: 500.milliseconds).fade().moveY(begin: 50, end: 0)
          ],
        ),
      ),
    );
  }

  @override
  SiginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SiginViewModel();
}
