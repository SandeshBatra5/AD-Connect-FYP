import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/common/app_strings.dart';
import 'package:billboard/ui/common/ui_helpers.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:billboard/ui/common/uihelper/text_veiw_helper.dart';
import 'package:billboard/ui/widgets/common/top/top.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:stacked/stacked.dart';

import '../../common/uihelper/button_helper.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Top(
                txt: "Login",
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
                        text_helper(
                          data: "Welcome",
                          font: poppins,
                          color: kcDarkGreyColor,
                          size: fontSize22,
                          bold: true,
                        )
                            .animate(delay: 700.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        text_view_helper(
                          hint: "Enter Phone Number",
                          controller: viewModel.phone,
                          showicon: true,
                          maxlength: 11,
                          formatter: [
                            FilteringTextInputFormatter.allow(getRegExpint())
                          ],
                          textInputType: TextInputType.phone,
                          icon: const Icon(Icons.call),
                        )
                            .animate(delay: 900.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        Container(
                          padding: const EdgeInsetsDirectional.all(5),
                          margin: const EdgeInsetsDirectional.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: text_view_helper(
                                  margin: const EdgeInsetsDirectional.all(0),
                                  padding: const EdgeInsetsDirectional.all(0),
                                  hint: "Enter Password",
                                  controller: viewModel.pass,
                                  obsecure: viewModel.o,
                                  showicon: true,
                                  icon: const Icon(Icons.password),
                                ),
                              ),
                              InkWell(
                                  onTap: () => viewModel.updato(),
                                  child: Icon(viewModel.o
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye_outlined))
                            ],
                          ),
                        )
                            .animate(delay: 1100.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        button_helper(
                                onpress: () => viewModel.login(context),
                                color: golden,
                                width: screenHeightCustom(context, 0.2),
                                child: text_helper(
                                  data: "Login",
                                  font: poppins,
                                  color: white,
                                  size: fontSize18,
                                  bold: true,
                                ))
                            .animate(delay: 1300.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                        InkWell(
                          onTap: () => viewModel.signup(),
                          child: text_helper(
                            data: "Do not have Account",
                            font: poppins,
                            color: kcDarkGreyColor,
                            size: fontSize12,
                          ),
                        )
                            .animate(delay: 1500.milliseconds)
                            .fade()
                            .moveY(begin: 50, end: 0),
                      ],
                    ),
                  ),
                ),
              ).animate(delay: 500.milliseconds).moveY(begin: 50, end: 0)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> permission() async {
    await Permission.notification.request();
  }

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    permission();
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
