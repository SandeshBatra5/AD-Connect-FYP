import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/apihelpers/apihelper.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../../common/uihelper/text_helper.dart';
import '../../widgets/common/addreviews/addreviews.dart';
import 'reviews_viewmodel.dart';

class ReviewsView extends StackedView<ReviewsViewModel> {
  ReviewsView({Key? key, required this.data}) : super(key: key);
  Map data;

  @override
  Widget builder(
    BuildContext context,
    ReviewsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: golden,
        title: text_helper(
          data: "Reviews",
          font: montserrat,
          color: kcDarkGreyColor,
          size: fontSize16,
          bold: true,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceSmall,
            div("Rating", context),
            verticalSpaceTiny,
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedRatingStars(
                    initialRating: int.parse(data['itemrating']) /
                        int.parse(data['itemuser']),
                    minRating: 0.0,
                    maxRating: 5.0,
                    filledColor: Colors.amber,
                    emptyColor: Colors.grey,
                    filledIcon: Icons.star,
                    halfFilledIcon: Icons.star_half,
                    emptyIcon: Icons.star_border,
                    onChanged: (double rating) {},
                    displayRatingValue: true,
                    interactiveTooltips: true,
                    customFilledIcon: Icons.star,
                    customHalfFilledIcon: Icons.star_half,
                    customEmptyIcon: Icons.star_border,
                    starSize: 20,
                    animationDuration: const Duration(milliseconds: 300),
                    animationCurve: Curves.easeInOut,
                    readOnly: true,
                  ),
                  text_helper(
                      data:
                          "Total Rating ${int.parse(data['itemrating']) / int.parse(data['itemuser'])}",
                      font: montserrat,
                      color: kcPrimaryColor,
                      size: fontSize14)
                ],
              ),
            ),
            verticalSpaceTiny,
            div("Review", context),
            Expanded(
                child: ListView.builder(
              itemCount: data['reviews'].length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: getColorWithOpacity(kcVeryLightGrey, 0.7),
                  ),
                  child: FutureBuilder(
                    future: ApiHelper.getonuser(
                        viewModel.sharedpref.readString("number")),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          children: [
                            CachedNetworkImage(
                                imageUrl: snapshot.data['img'],
                                imageBuilder: (context, imageProvider) =>
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        width: screenWidthCustom(context, 0.12),
                                        height:
                                            screenWidthCustom(context, 0.12),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                    displaysimpleprogress(context),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      'assets/person.png',
                                      fit: BoxFit.cover,
                                      height: screenWidthCustom(context, 0.12),
                                      width: screenWidthCustom(context, 0.12),
                                    )),
                            horizontalSpaceSmall,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text_helper(
                                    data: snapshot.data['name'],
                                    font: poppins,
                                    bold: true,
                                    color: kcDarkGreyColor,
                                    size: fontSize14),
                                text_helper(
                                    data: data['reviews'][index]['review']
                                        .toString(),
                                    font: montserrat,
                                    color: kcDarkGreyColor,
                                    size: fontSize10),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Icon(
                          Icons.error,
                          color: kcDarkGreyColor,
                        );
                      } else {
                        return displaysimpleprogress(context);
                      }
                    },
                  ),
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: white,
                  child: Addreviews(data: data),
                );
              });
        },
        backgroundColor: golden,
        child: const Icon(Icons.add, color: kcDarkGreyColor),
      ),
    );
  }

  Widget div(String d, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(Icons.highlight_alt_sharp),
          horizontalSpaceTiny,
          text_helper(
              data: d,
              font: poppins,
              bold: true,
              color: kcDarkGreyColor,
              size: fontSize14),
        ],
      ),
    );
  }

  @override
  ReviewsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ReviewsViewModel();
}
