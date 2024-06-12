import 'package:billboard/ui/views/signup/signup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';

class SiginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefService>();

  void billboard() {
    _sharedpref.setString("cat", "billboard");
    _navigationService.navigateWithTransition(const SignupView(),
        routeName: Routes.signupView, transitionStyle: Transition.rightToLeft);
  }

  void user() {
    _sharedpref.setString("cat", "user");
    _navigationService.navigateWithTransition(const SignupView(),
        routeName: Routes.signupView, transitionStyle: Transition.rightToLeft);
  }
}
