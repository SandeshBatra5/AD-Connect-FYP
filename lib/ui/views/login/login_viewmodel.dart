import 'package:billboard/ui/views/admin/admin_view.dart';
import 'package:billboard/ui/views/sigin/sigin_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/fire_service.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/apihelpers/apihelper.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../billboardowner/billboardowner_view.dart';
import '../home/home_view.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefService>();
  final _fireService = locator<FireService>();

  TextEditingController pass = TextEditingController();
  TextEditingController phone = MaskedTextController(mask: '0000-0000000');

  void login(BuildContext context) {
    if (phone.text.isEmpty || pass.text.isEmpty) {
      show_snackbar(context, "fill all fields");
    } else if (phone.text.length != 12) {
      show_snackbar(context, "Number is not correct");
    } else if (phone.text == "0000-0000000" && pass.text == "admin") {
      _sharedpref.setString('number', phone.text);
      _navigationService.clearStackAndShow(Routes.adminView);
      _navigationService.replaceWithTransition(const AdminView(),
          routeName: Routes.adminView, transitionStyle: Transition.rightToLeft);
    } else {
      displayprogress(context);
      var result = _fireService.messaging.getToken().then((value) {
        return ApiHelper.login(
            phone.text, pass.text, value.toString(), context);
      });
      result.then((value) {
        if (value.isNotEmpty) {
          _sharedpref.setString('name', value['name']);
          _sharedpref.setString('cnic', value['cnic']);
          _sharedpref.setString('img', value['img']);
          _sharedpref.setString('number', phone.text);
          _sharedpref.setString('address', value['address']);
          _sharedpref.setString('dob', value['dob']);
          _sharedpref.setString('cat', value['cat']);
          _sharedpref.setString('deviceid', value.toString());

          _sharedpref.setString("auth", 'true');
          hideprogress(context);

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
        }
      });
    }
  }

  void signup() {
    _navigationService.navigateWithTransition(const SiginView(),
        routeName: Routes.siginView, transitionStyle: Transition.rightToLeft);
  }

  bool o = true;
  void updato() {
    o = !o;
    notifyListeners();
  }
}
