import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app.locator.dart';
import '../../../../services/sharedpref_service.dart';
import '../../../common/apihelpers/apihelper.dart';
import '../../../common/uihelper/snakbar_helper.dart';

class AddreviewsModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();

  TextEditingController review = TextEditingController();
  double rating = 0.0;

  Future<void> addreview(BuildContext context, Map data) async {
    if (review.text.isEmpty) {
      show_snackbar(context, "Please add review");
    } else {
      await ApiHelper.updatedbillboardrating(
          data["_id"],
          rating,
          {
            "review": review.text,
            "uid": sharedpref.readString("number"),
          },
          context);
      Navigator.pop(context);
    }
  }
}
