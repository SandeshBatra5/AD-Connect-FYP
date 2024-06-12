import 'package:billboard/services/sharedpref_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../chating/chating_view.dart';

class AllchatsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final sharedpref = locator<SharedprefService>();

  void move(String idd, String did) {
    _navigationService.navigateWithTransition(
        ChatingView(
          id: idd,
          did: did,
        ),
        routeName: Routes.chatingView,
        transitionStyle: Transition.rightToLeft);
  }
}
