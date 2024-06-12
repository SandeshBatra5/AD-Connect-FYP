// ignore_for_file: use_build_context_synchronously

import 'package:billboard/ui/views/addpic/addpic_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/fire_service.dart';
import '../../common/uihelper/snakbar_helper.dart';

class OtpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _fireService = locator<FireService>();

  TextEditingController otp = TextEditingController();
  String verficationid = '';

  Future<void> next(BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verficationid, smsCode: otp.text);
    var check = await _fireService.auth.signInWithCredential(credential);
    if (check.additionalUserInfo!.isNewUser) {
      _navigationService.navigateWithTransition(const AddpicView(),
          routeName: Routes.addpicView,
          transitionStyle: Transition.rightToLeft);
    } else {
      show_snackbar(context, "alreadyregisteredgotologin");
      _navigationService.back();
    }
  }

  void first(String v) {
    verficationid = v;
  }
}
