import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/widgets/common/top/top.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import '../../common/uihelper/button_helper.dart';
import '../../common/uihelper/text_helper.dart';
import '../../common/uihelper/text_veiw_helper.dart';
import 'addpass_viewmodel.dart';

class AddpassView extends StackedView<AddpassViewModel> {
  const AddpassView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddpassViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Top(txt: "Enter Password"),
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
                        Container(
                          width: screenHeightCustom(context, 1),
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: white),
                          child: FancyPasswordField(
                            passwordController: viewModel.passv,
                            controller: viewModel.pass,
                            style: text_helper.customstyle(poppins,
                                kcDarkGreyColor, fontSize14, context, false),
                            decoration: InputDecoration(
                                hintText: "Enter Password",
                                hintStyle: text_helper.customstyle(
                                    poppins,
                                    kcDarkGreyColor,
                                    fontSize14,
                                    context,
                                    false),
                                prefixIcon: const Icon(Icons.password)),
                            validationRules: {
                              DigitValidationRule(),
                              UppercaseValidationRule(),
                              LowercaseValidationRule(),
                              SpecialCharacterValidationRule(),
                              MinCharactersValidationRule(6),
                            },
                            validationRuleBuilder: (rules, value) {
                              if (value.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return ListView(
                                shrinkWrap: true,
                                children: rules
                                    .map(
                                      (rule) => rule.validate(value)
                                          ? Row(
                                              children: [
                                                const Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                                const SizedBox(width: 12),
                                                text_helper(
                                                    data: rule.name,
                                                    font: poppins,
                                                    color: Colors.green,
                                                    size: fontSize12),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                                const SizedBox(width: 12),
                                                text_helper(
                                                    data: rule.name,
                                                    font: poppins,
                                                    color: Colors.red,
                                                    size: fontSize12),
                                              ],
                                            ),
                                    )
                                    .toList(),
                              );
                            },
                          )
                              .animate(delay: 700.milliseconds)
                              .fade()
                              .moveY(begin: 50, end: 0),
                        ),
                        text_view_helper(
                          hint: "Confirm Password",
                          controller: viewModel.conpass,
                          showicon: true,
                          obsecure: true,
                          icon: const Icon(Icons.password),
                        )
                            .animate(delay: 900.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        button_helper(
                          onpress: () => viewModel.next(context),
                          color: golden,
                          width: screenWidthCustom(context, 0.6),
                          raduis: 20,
                          padding: const EdgeInsetsDirectional.all(8),
                          child: text_helper(
                            data: "make account",
                            font: poppins,
                            color: white,
                            size: fontSize18,
                            bold: true,
                          )
                              .animate(delay: 1300.milliseconds)
                              .fade()
                              .moveY(begin: 50, end: 0),
                        )
                            .animate(delay: 1100.milliseconds)
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
      ),
    );
  }

  @override
  AddpassViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddpassViewModel();
}
