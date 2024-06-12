import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/apihelpers/apihelper.dart';
import '../booking/booking_view.dart';

class WishlistViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final sharedpref = locator<SharedprefService>();

  void booking(Map data) {
    _navigationService.navigateWithTransition(
        BookingView(
          data: data,
        ),
        routeName: Routes.bookingView,
        transitionStyle: Transition.rightToLeft);
  }

  Future<void> registerwishlist(
      BuildContext context, String number, String id) async {
    await ApiHelper.registerwishlist(number, id, context);
    notifyListeners();
  }

  Future<void> deletewishlist(BuildContext context, String id) async {
    await ApiHelper.wishlistdelete(id, context);
    notifyListeners();
  }

  Future<String> loc(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      Placemark place = placemarks[0];
      return "Street : ${place.street} , country ${place.country}";
    } catch (e) {
      return "";
    }
  }
}
