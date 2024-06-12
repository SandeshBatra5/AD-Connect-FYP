// ignore_for_file: use_build_context_synchronously

import 'package:billboard/ui/views/addpic/addpic_view.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/uihelper/snakbar_helper.dart';

class AddpassViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefService>();

  FancyPasswordController passv = FancyPasswordController();
  TextEditingController pass = TextEditingController();
  TextEditingController conpass = TextEditingController();

  void next(BuildContext context) {
    if (pass.text.isEmpty || conpass.text.isEmpty) {
      show_snackbar(context, "fill all fields");
    } else if (!passv.areAllRulesValidated) {
      show_snackbar(context, "password is not strong");
    } else if (pass.text != conpass.text) {
      show_snackbar(context, "pass and confirm pass do not match");
    } else {
      _sharedpref.setString('pass', pass.text);
      _navigationService.navigateWithTransition(const AddpicView(),
          routeName: Routes.addpicView,
          transitionStyle: Transition.rightToLeft);
    }
  }
}
