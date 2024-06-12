import 'package:billboard/ui/common/apihelpers/apihelper.dart';
import 'package:billboard/ui/common/uihelper/snakbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/sharedpref_service.dart';

class OrdersViewModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();

  Future<void> aspect(
      String custnumber, String ownernumber, BuildContext context) async {
    displayprogress(context);
    await ApiHelper.updatestatus(custnumber, ownernumber, context);
    hideprogress(context);
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
