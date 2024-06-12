import 'package:billboard/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import '../../common/uihelper/button_helper.dart';
import '../../common/uihelper/text_helper.dart';
import '../../common/uihelper/text_veiw_helper.dart';
import '../../widgets/common/top/top.dart';
import 'signup_viewmodel.dart';

class SignupView extends StackedView<SignupViewModel> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Top(
                txt: "Sign up",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipPath(
                  clipper: RoundedDiagonalPathClipper(),
                  child: Container(
                    height: screenHeightCustom(context, 0.7),
                    width: screenWidth(context),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      color: getColorWithOpacity(kcPrimaryColor, 0.6),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        text_view_helper(
                          hint: "Enter name",
                          controller: viewModel.name,
                          showicon: true,
                          formatter: [
                            FilteringTextInputFormatter.allow(getRegExpstring())
                          ],
                        )
                            .animate(delay: 700.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        text_view_helper(
                          hint: "Enter number",
                          controller: viewModel.number,
                          showicon: true,
                          icon: const Icon(Icons.call),
                          maxlength: 11,
                          formatter: [
                            FilteringTextInputFormatter.allow(getRegExpint())
                          ],
                          textInputType: TextInputType.phone,
                        )
                            .animate(delay: 900.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        text_view_helper(
                          hint: "Enter cnic",
                          controller: viewModel.cnic,
                          showicon: true,
                          formatter: [
                            FilteringTextInputFormatter.allow(getRegExpint())
                          ],
                          icon: const Icon(Icons.dock),
                          maxlength: 13,
                          textInputType: TextInputType.phone,
                        )
                            .animate(delay: 1100.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        text_view_helper(
                                hint: "Enter address",
                                controller: viewModel.address,
                                showicon: true,
                                icon: const Icon(Icons.home))
                            .animate(delay: 1300.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        InkWell(
                          onTap: () => viewModel.selectdob(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: text_helper(
                                data: viewModel.dob.text == ''
                                    ? "Select Date of Birth"
                                    : viewModel.dob.text,
                                font: poppins,
                                color: kcDarkGreyColor,
                                size: fontSize14),
                          ),
                        )
                            .animate(delay: 1500.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        button_helper(
                                onpress: () => viewModel.next(context),
                                color: golden,
                                width: screenWidthCustom(context, 0.3),
                                child: text_helper(
                                    data: "Next",
                                    font: poppins,
                                    color: white,
                                    bold: true,
                                    size: fontSize14))
                            .animate(delay: 1700.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0)
                      ],
                    ),
                  ),
                ),
              ).animate(delay: 500.milliseconds).fade().moveY(begin: 50, end: 0)
            ],
          ),
        ),
      ),
    );
  }

  @override
  SignupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignupViewModel();
}
