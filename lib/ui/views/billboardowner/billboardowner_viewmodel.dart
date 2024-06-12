import 'package:billboard/ui/views/login/login_view.dart';
import 'package:billboard/ui/views/uploadbillboard/uploadbillboard_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../chat/allchats/allchats_view.dart';
import '../orders/orders_view.dart';
import '../wallet/wallet_view.dart';

class BillboardownerViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final sharedpref = locator<SharedprefService>();

  void wallet() {
    _navigationService.navigateWithTransition(const WalletView(),
        routeName: Routes.bookingView, transitionStyle: Transition.rightToLeft);
  }

  void order() {
    _navigationService.navigateWithTransition(
        OrdersView(
          user: false,
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

  void upload(Map data, bool update) {
    _navigationService.navigateWithTransition(
        UploadbillboardView(
          data: data,
          update: update,
        ),
        routeName: Routes.uploadbillboardView,
        transitionStyle: Transition.rightToLeft);
  }

  Future<String> loc(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      Placemark place = placemarks[0];
      return "Street : ${place.street} , locality ${place.locality} , postalCode ${place.postalCode} "
          ", country ${place.country}";
    } catch (e) {
      return "";
    }
  }

  Future<void> first() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
