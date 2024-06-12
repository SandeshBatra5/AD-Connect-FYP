import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/uihelper/snakbar_helper.dart';
import 'customslider_model.dart';

class Customslider extends StackedView<CustomsliderModel> {
  Customslider({super.key, required this.data});
  List data;

  @override
  Widget builder(
    BuildContext context,
    CustomsliderModel viewModel,
    Widget? child,
  ) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: false,
      ),
      items: data.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: i,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                    color: kcPrimaryColor,
                    strokeWidth: 10,
                  )),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: kcDarkGreyColor,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  CustomsliderModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomsliderModel();
}
