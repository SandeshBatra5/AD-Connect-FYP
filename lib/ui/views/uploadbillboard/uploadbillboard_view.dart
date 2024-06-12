// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/common/app_strings.dart';
import 'package:billboard/ui/common/ui_helpers.dart';
import 'package:billboard/ui/common/uihelper/button_helper.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:billboard/ui/common/uihelper/text_veiw_helper.dart';
import 'package:billboard/ui/widgets/common/top/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';

import 'uploadbillboard_viewmodel.dart';

class UploadbillboardView extends StackedView<UploadbillboardViewModel> {
  UploadbillboardView({Key? key, required this.data, required this.update})
      : super(key: key);
  Map data;
  bool update;

  @override
  Widget builder(
    BuildContext context,
    UploadbillboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Top(txt: "Add Bill Board"),
                button_helper(
                        onpress: () => viewModel.pickImages(),
                        color: getColorWithOpacity(kcPrimaryColor, 0.5),
                        width: screenWidth(context),
                        child: text_helper(
                          data: "Add Pics",
                          font: poppins,
                          color: white,
                          size: fontSize14,
                          bold: true,
                        ))
                    .animate(delay: 500.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
                viewModel.selectedImages.isEmpty
                    ? text_helper(
                            data: "Add Pics of your Bill Board",
                            font: poppins,
                            color: kcDarkGreyColor,
                            size: fontSize14)
                        .animate(delay: 600.milliseconds)
                        .fade()
                        .moveY(begin: 50, end: 0)
                    : SizedBox(
                        width: screenWidth(context),
                        height: screenHeightCustom(context, 0.2),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: viewModel.selectedImages
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(File(e.path))),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: InkWell(
                                              onTap: () => viewModel.delete(e),
                                              child: const Icon(
                                                Icons.delete,
                                                color: red,
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                      .animate(delay: 500.milliseconds)
                                      .fade()
                                      .moveY(begin: 50, end: 0))
                              .toList(),
                        ),
                      ),
                viewModel.alreadyimg.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          verticalSpaceSmall,
                          text_helper(
                                  data: "Already Added Pics",
                                  font: poppins,
                                  color: kcDarkGreyColor,
                                  size: fontSize14)
                              .animate(delay: 600.milliseconds)
                              .fade()
                              .moveY(begin: 50, end: 0),
                          SizedBox(
                            width: screenWidth(context),
                            height: screenHeightCustom(context, 0.2),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: viewModel.alreadyimg
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(e)),
                                            Positioned(
                                              top: 5,
                                              right: 5,
                                              child: InkWell(
                                                  onTap: () => viewModel
                                                      .deletealready(e),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: red,
                                                  )),
                                            )
                                          ],
                                        ),
                                      )
                                          .animate(delay: 500.milliseconds)
                                          .fade()
                                          .moveY(begin: 50, end: 0))
                                  .toList(),
                            ),
                          )
                              .animate(delay: 600.milliseconds)
                              .fade()
                              .moveY(begin: 50, end: 0),
                        ],
                      ),
                text_view_helper(
                        showicon: true,
                        icon: const Icon(Icons.currency_rupee),
                        textInputType: TextInputType.phone,
                        formatter: [
                          FilteringTextInputFormatter.allow(getRegExpint())
                        ],
                        hint: "Price per Day",
                        controller: viewModel.price)
                    .animate(delay: 700.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidthCustom(context, 0.5),
                      child: text_view_helper(
                              showicon: true,
                              icon: const Icon(Icons.width_full_sharp),
                              textInputType: TextInputType.phone,
                              formatter: [
                                FilteringTextInputFormatter.allow(
                                    getRegExpint())
                              ],
                              hint: "Width",
                              controller: viewModel.width)
                          .animate(delay: 800.milliseconds)
                          .fade()
                          .moveY(begin: 50, end: 0),
                    ),
                    SizedBox(
                      width: screenWidthCustom(context, 0.5),
                      child: text_view_helper(
                              showicon: true,
                              icon: const Icon(Icons.height),
                              textInputType: TextInputType.phone,
                              formatter: [
                                FilteringTextInputFormatter.allow(
                                    getRegExpint())
                              ],
                              hint: "height",
                              controller: viewModel.height)
                          .animate(delay: 900.milliseconds)
                          .fade()
                          .moveY(begin: 50, end: 0),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    button_helper(
                            onpress: () => viewModel.location(),
                            color: kcPrimaryColor,
                            width: screenWidthCustom(context, 0.1),
                            child: const Icon(
                              Icons.location_on,
                              color: white,
                            ))
                        .animate(delay: 1000.milliseconds)
                        .fade()
                        .moveY(begin: 50, end: 0),
                    SizedBox(
                      width: screenWidthCustom(context, 0.4),
                      child: text_view_helper(
                              showicon: true,
                              icon: const Icon(Icons.location_on),
                              textInputType: TextInputType.phone,
                              formatter: [
                                FilteringTextInputFormatter.allow(
                                    getRegExpint())
                              ],
                              hint: "Latitude",
                              controller: viewModel.lat)
                          .animate(delay: 1000.milliseconds)
                          .fade()
                          .moveY(begin: 50, end: 0),
                    ),
                    SizedBox(
                      width: screenWidthCustom(context, 0.4),
                      child: text_view_helper(
                              showicon: true,
                              icon: const Icon(Icons.location_on),
                              textInputType: TextInputType.phone,
                              formatter: [
                                FilteringTextInputFormatter.allow(
                                    getRegExpint())
                              ],
                              hint: "Longitude",
                              controller: viewModel.lon)
                          .animate(delay: 1100.milliseconds)
                          .fade()
                          .moveY(begin: 50, end: 0),
                    )
                  ],
                ),
                text_view_helper(
                        showicon: true,
                        icon: const Icon(Icons.description),
                        hint: "Description",
                        controller: viewModel.des)
                    .animate(delay: 1200.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => viewModel.selectdate(context),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: text_helper(
                          data: viewModel.date.text.isEmpty
                              ? "Next Avaliable Date"
                              : viewModel.date.text,
                          font: poppins,
                          color: kcLightGrey,
                          size: fontSize14),
                    ),
                  ),
                )
                    .animate(delay: 1300.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
                update
                    ? button_helper(
                            onpress: () => viewModel.update(context, data['_id']),
                            color: getColorWithOpacity(golden, 1),
                            width: screenWidthCustom(context, 0.5),
                            child: text_helper(
                              data: "Update",
                              font: poppins,
                              color: white,
                              size: fontSize14,
                              bold: true,
                            ))
                        .animate(delay: 1400.milliseconds)
                        .fade()
                        .moveY(begin: 50, end: 0)
                    : button_helper(
                            onpress: () => viewModel.save(context),
                            color: getColorWithOpacity(golden, 1),
                            width: screenWidthCustom(context, 0.5),
                            child: text_helper(
                              data: "Add",
                              font: poppins,
                              color: white,
                              size: fontSize14,
                              bold: true,
                            ))
                        .animate(delay: 1400.milliseconds)
                        .fade()
                        .moveY(begin: 50, end: 0),
              ],
            ),
          ),
        ));
  }

  @override
  void onViewModelReady(UploadbillboardViewModel viewModel) =>
      viewModel.firstrun(data);

  @override
  UploadbillboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UploadbillboardViewModel();
}
