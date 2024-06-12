import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/widgets/common/top/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import '../../common/uihelper/button_helper.dart';
import '../../common/uihelper/text_helper.dart';
import 'addpic_viewmodel.dart';

class AddpicView extends StackedView<AddpicViewModel> {
  const AddpicView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddpicViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Column(
            children: [
              Top(txt: "Add Pic"),
              viewModel.image == null
                  ? InkWell(
                      onTap: () => viewModel.pic(),
                      child: Icon(
                        Icons.person,
                        size: screenWidthCustom(context, 0.5),
                      ),
                    )
                      .animate(delay: 700.milliseconds)
                      .fade()
                      .moveY(begin: 50, end: 0)
                  : InkWell(
                      onTap: () => viewModel.pic(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            viewModel.image!,
                            width: screenWidth(context),
                            fit: BoxFit.cover,
                            height: screenWidth(context),
                          ).animate(delay: 500.milliseconds).fade(),
                        ),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button_helper(
                          onpress: () => viewModel.next(context, false),
                          color: golden,
                          width: screenWidthCustom(context, 0.3),
                          raduis: 20,
                          padding: const EdgeInsetsDirectional.all(8),
                          child: text_helper(
                            data: "Skip",
                            font: poppins,
                            color: white,
                            size: fontSize18,
                            bold: true,
                          ))
                      .animate(delay: 900.milliseconds)
                      .fade()
                      .moveY(begin: 50, end: 0),
                  button_helper(
                          onpress: () => viewModel.next(context, true),
                          color: golden,
                          width: screenWidthCustom(context, 0.3),
                          raduis: 20,
                          padding: const EdgeInsetsDirectional.all(8),
                          child: text_helper(
                            data: "Next",
                            font: poppins,
                            color: white,
                            size: fontSize18,
                            bold: true,
                          ))
                      .animate(delay: 900.milliseconds)
                      .fade()
                      .moveY(begin: 50, end: 0),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  AddpicViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddpicViewModel();
}
