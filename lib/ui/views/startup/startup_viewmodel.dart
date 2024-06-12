import 'package:billboard/ui/views/billboardowner/billboardowner_view.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:billboard/app/app.locator.dart';
import 'package:billboard/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/sharedpref_service.dart';
import '../home/home_view.dart';
import '../login/login_view.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefService>();

  Future runStartupLogic() async {
    _sharedpref.initialize();
    hideStatusBar();
    await Future.delayed(const Duration(seconds: 3));
    showStatusBar();
    _navigationService.replaceWithTransition(const LoginView(),
        routeName: Routes.loginView, transitionStyle: Transition.rightToLeft);
    if (_sharedpref.contains('auth') &&
        _sharedpref.readString('auth') == 'true') {
      if (_sharedpref.readString('cat') == 'user') {
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
      _navigationService.replaceWithTransition(const LoginView(),
          routeName: Routes.loginView, transitionStyle: Transition.rightToLeft);
    }
  }

  void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    notifyListeners();
  }

  void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    notifyListeners();
  }
}
