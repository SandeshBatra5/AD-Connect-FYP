import 'package:billboard/ui/views/addpass/addpass_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/fire_service.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../otp/otp_view.dart';

class SignupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefService>();
  final _fireService = locator<FireService>();

  TextEditingController name = TextEditingController();
  TextEditingController number = MaskedTextController(mask: '0000-0000000');
  TextEditingController cnic = MaskedTextController(mask: '00000-0000000-0');
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();

  Future<void> selectdob(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dob.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      notifyListeners();
    }
  }

  Future<void> next(BuildContext context) async {
    if (name.text.isEmpty ||
        number.text.isEmpty ||
        cnic.text.isEmpty ||
        address.text.isEmpty ||
        dob.text.isEmpty) {
      show_snackbar(context, "Fill all fields");
    } else if (number.text.length != 12) {
      show_snackbar(context, "Number is not correct");
    } else if (cnic.text.length != 15) {
      show_snackbar(context, "Enter cnic with dash");
    } else {
      displayprogress(context);
      _sharedpref.setString('name', name.text);
      _sharedpref.setString('number', number.text);
      _sharedpref.setString('cnic', cnic.text);
      _sharedpref.setString('address', address.text);
      _sharedpref.setString('dob', dob.text);
      // hideprogress(context);
     //  await _fireService.auth.verifyPhoneNumber(
     //    phoneNumber: '+92${number.text.toString().substring(1)}',
     //    verificationCompleted: (PhoneAuthCredential credential) async {
     //      await _fireService.auth.signInWithCredential(credential);
     //    },
     //    verificationFailed: (FirebaseAuthException e) {
     //      hideprogress(context);
     //      show_snackbar(context, "try again later");
     //    },
     //    codeSent: (String verificationId, int? resendToken) async {
     //      hideprogress(context);
     //      _navigationService.navigateWithTransition(
     //          OtpView(
     //            id: verificationId,
     //          ),
     //          routeName: Routes.otpView,
     //          transitionStyle: Transition.fade);
     //    },
     //    codeAutoRetrievalTimeout: (String verificationId) {},
     //  );

      _navigationService.navigateWithTransition(const AddpassView(),
           routeName: Routes.addpassView,
           transitionStyle: Transition.rightToLeft);
    }
  }
}
