import 'package:billboard/ui/views/booking/booking_view.dart';
import 'package:billboard/ui/views/chat/allchats/allchats_view.dart';
import 'package:billboard/ui/views/orders/orders_view.dart';
import 'package:billboard/ui/views/wallet/wallet_view.dart';
import 'package:billboard/ui/views/wishlist/wishlist_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/apihelpers/apihelper.dart';
import '../login/login_view.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final sharedpref = locator<SharedprefService>();

  TextEditingController search = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController widthe = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController heighte = TextEditingController();
  TextEditingController prizes = TextEditingController();
  TextEditingController prizee = TextEditingController();
  bool applyfil = false;
  void applyfilter() {
    _navigationService.back();
    applyfil = true;
    notifyListeners();
  }

  void canclefilter() {
    width.clear();
    widthe.clear();
    height.clear();
    heighte.clear();
    prizes.clear();
    prizee.clear();
    _navigationService.back();
    applyfil = false;
    notifyListeners();
  }

  void wallet() {
    _navigationService.navigateWithTransition(const WalletView(),
        routeName: Routes.bookingView, transitionStyle: Transition.rightToLeft);
  }

  void order() {
    _navigationService.navigateWithTransition(
        OrdersView(
          user: true,
        ),
        routeName: Routes.bookingView,
        transitionStyle: Transition.rightToLeft);
  }

  void wishlist() {
    _navigationService.navigateWithTransition(const WishlistView(),
        routeName: Routes.bookingView, transitionStyle: Transition.rightToLeft);
  }

  void allchats() {
    _navigationService.navigateWithTransition(const AllchatsView(),
        routeName: Routes.allchatsView,
        transitionStyle: Transition.rightToLeft);
  }

  void booking(Map data) {
    _navigationService.navigateWithTransition(
        BookingView(
          data: data,
        ),
        routeName: Routes.bookingView,
        transitionStyle: Transition.rightToLeft);
  }

  void logout() {
    sharedpref.remove('name');
    sharedpref.remove('cnic');
    sharedpref.remove('number');
    sharedpref.remove('address');
    sharedpref.remove('dob');
    sharedpref.remove('cat');
    sharedpref.remove('img');
    sharedpref.setString("auth", 'false');
    _navigationService.clearStackAndShow(Routes.loginView);
    _navigationService.replaceWithTransition(const LoginView(),
        routeName: Routes.loginView, transitionStyle: Transition.rightToLeft);
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

  Future<void> registerwishlist(
      BuildContext context, String number, String id) async {
    await ApiHelper.registerwishlist(number, id, context);
    notifyListeners();
  }

  Future<void> deletewishlist(BuildContext context, String id) async {
    await ApiHelper.wishlistdelete(id, context);
    notifyListeners();
  }
}
