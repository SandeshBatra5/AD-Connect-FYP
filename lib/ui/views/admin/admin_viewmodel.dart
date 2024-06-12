import 'package:billboard/ui/common/apihelpers/apihelper.dart';
import 'package:billboard/ui/common/uihelper/snakbar_helper.dart';
import 'package:billboard/ui/views/login/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../booking/booking_view.dart';
import '../chat/allchats/allchats_view.dart';

class AdminViewModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();
  final _navigationService = locator<NavigationService>();

  Future<String> loc(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      Placemark place = placemarks[0];
      return "Street : ${place.street} , country ${place.country}";
    } catch (e) {
      return "";
    }
  }

  void booking(Map data) {
    _navigationService.navigateWithTransition(
        BookingView(
          data: data,
          isadmin: true,
        ),
        routeName: Routes.bookingView,
        transitionStyle: Transition.rightToLeft);
  }

  void allchats() {
    _navigationService.navigateWithTransition(const AllchatsView(),
        routeName: Routes.allchatsView,
        transitionStyle: Transition.rightToLeft);
  }

  void logout() {
    _navigationService.clearStackAndShow(Routes.loginView);
    _navigationService.replaceWithTransition(const LoginView(),
        routeName: Routes.loginView, transitionStyle: Transition.rightToLeft);
  }

  Future<void> approve(String status,String id,BuildContext context) async {
    bool c = await ApiHelper.updatebillboardstatus(id, status, context);
    if(c){
      Navigator.pop(context);
      show_snackbar(context, "Updated");
    }
  }

}
