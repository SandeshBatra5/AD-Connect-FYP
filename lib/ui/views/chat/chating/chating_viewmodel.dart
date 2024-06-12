import 'package:billboard/services/sharedpref_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app.locator.dart';

class ChatingViewModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();
  TextEditingController chat = TextEditingController();
}
