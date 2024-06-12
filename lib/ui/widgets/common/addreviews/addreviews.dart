import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_strings.dart';
import '../../../common/ui_helpers.dart';
import '../../../common/uihelper/button_helper.dart';
import '../../../common/uihelper/text_helper.dart';
import '../../../common/uihelper/text_veiw_helper.dart';
import 'addreviews_model.dart';

class Addreviews extends StackedView<AddreviewsModel> {
  Addreviews({super.key, required this.data});
  Map data;

  @override
  Widget builder(
    BuildContext context,
    AddreviewsModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: white,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: text_helper(
                  data: "Add Review",
                  bold: true,
                  font: montserrat,
                  color: kcPrimaryColor,
                  size: fontSize18),
            ),
            text_helper(
                data: "How was your experience",
                font: montserrat,
                color: kcPrimaryColor,
                size: fontSize14),
            AnimatedRatingStars(
              initialRating:
                  int.parse(data['itemrating']) / int.parse(data['itemuser']),
              minRating: 0.0,
              maxRating: 5.0,
              filledColor: Colors.amber,
              emptyColor: Colors.grey,
              filledIcon: Icons.star,
              halfFilledIcon: Icons.star_half,
              emptyIcon: Icons.star_border,
              onChanged: (double rating) {
                viewModel.rating = rating;
                viewModel.notifyListeners();
              },
              displayRatingValue: true,
              interactiveTooltips: true,
              customFilledIcon: Icons.star,
              customHalfFilledIcon: Icons.star_half,
              customEmptyIcon: Icons.star_border,
              starSize: 20,
              animationDuration: const Duration(milliseconds: 300),
              animationCurve: Curves.easeInOut,
              readOnly: false,
            ),
            text_helper(
                data: "write your review",
                font: montserrat,
                color: kcPrimaryColor,
                size: fontSize14),
            text_view_helper(
                hint: "Add Review",
                showicon: true,
                icon: const Icon(Icons.reviews, color: kcPrimaryColor),
                controller: viewModel.review),
            button_helper(
                onpress: () => viewModel.addreview(context, data),
                color: kcPrimaryColor,
                width: screenWidth(context),
                child: text_helper(
                    data: "Add",
                    font: montserrat,
                    color: white,
                    bold: true,
                    size: fontSize14))
          ]),
    );
  }

  @override
  AddreviewsModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddreviewsModel();
}
