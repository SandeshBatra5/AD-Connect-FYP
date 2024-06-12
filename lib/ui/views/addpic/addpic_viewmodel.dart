// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/fire_service.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/apihelpers/apihelper.dart';
import '../../common/apihelpers/firebsaeuploadhelper.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../billboardowner/billboardowner_view.dart';
import '../home/home_view.dart';

class AddpicViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefService>();
  final _fireService = locator<FireService>();
  File? image;

  Future<void> pic() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> next(BuildContext context, bool up) async {
    displayprogress(context);
    String url = "";
    if (up) {
      url = await FirebaseHelper.uploadFile(
          image, _sharedpref.readString('number'));
    }
    _sharedpref.setString('img', url);
    displayprogress(context);
    Future<bool> result = _fireService.messaging.getToken().then((value) {
      _sharedpref.setString('deviceid', value.toString());
      return ApiHelper.registration(
        _sharedpref.readString('name'),
        _sharedpref.readString('cnic'),
        _sharedpref.readString('number'),
        _sharedpref.readString('address'),
        _sharedpref.readString('dob'),
        _sharedpref.readString('cat'),
        _sharedpref.readString('img'),
        _sharedpref.readString('pass'),
        value.toString(),
        context,
      );
    });
    result.then((value) async {
      if (value) {
        bool check = await ApiHelper.registerwallet(
            _sharedpref.readString('number'), context);
        if (check) {
          hideprogress(context);
          _sharedpref.setString("auth", 'true');
          if (_sharedpref.readString('cat') != 'billboard') {
            _navigationService.clearStackAndShow(Routes.homeView);
            _navigationService.replaceWithTransition(const HomeView(),
                routeName: Routes.homeView,
                transitionStyle: Transition.rightToLeft);
          } else {
            _navigationService.clearStackAndShow(Routes.billboardownerView);
            _navigationService.replaceWithTransition(const BillboardownerView(),
                routeName: Routes.billboardownerView,
                transitionStyle: Transition.rightToLeft);
          }
        } else {
          hideprogress(context);
          show_snackbar(context, 'try again later');
        }
      } else {
        hideprogress(context);
        show_snackbar(context, 'try again later');
      }
    });
  }
}
