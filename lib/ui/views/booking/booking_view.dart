// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings

import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/common/app_strings.dart';
import 'package:billboard/ui/common/ui_helpers.dart';
import 'package:billboard/ui/common/uihelper/button_helper.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:billboard/ui/widgets/common/customslider/customslider.dart';
import 'package:billboard/ui/widgets/common/top/top.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.router.dart';
import '../../common/apihelpers/apihelper.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../chat/chating/chating_view.dart';
import 'booking_viewmodel.dart';

class BookingView extends StackedView<BookingViewModel> {
  BookingView({Key? key, required this.data, this.isadmin = false})
      : super(key: key);
  Map data;
  bool isadmin;

  @override
  Widget builder(
    BuildContext context,
    BookingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Top(txt: "Book now !!"),
              Customslider(data: data['image']),
              verticalSpaceSmall,
              FutureBuilder(
                future: ApiHelper.getonuser(data['number']),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        horizontalSpaceSmall,
                        CachedNetworkImage(
                          imageUrl: snapshot.data['img'],
                          imageBuilder: (context, imageProvider) => ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: screenWidthCustom(context, 0.12),
                              height: screenWidthCustom(context, 0.12),
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
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: kcDarkGreyColor,
                          ),
                        ),
                        horizontalSpaceSmall,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text_helper(
                                data: snapshot.data['name'],
                                bold: true,
                                font: poppins,
                                color: kcDarkGreyColor,
                                size: fontSize16),
                            text_helper(
                                data: snapshot.data['number'],
                                font: poppins,
                                color: kcDarkGreyColor,
                                size: fontSize12),
                          ],
                        )
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              Container(
                width: screenWidth(context),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    linerow("Size", data['width'] + "x" + data['height']),
                    linerow("price", "\$" + data['price']),
                    linerow("Description", data['des']),
                    linerow("Avaliable", data['avaliable']),
                  ],
                ),
              ),
              InkWell(
                onTap: () =>
                    viewModel.openmap(context, data['lat'], data['lon']),
                child: Container(
                  width: screenWidth(context),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: getColorWithOpacity(kcLightGrey, 0.1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text_helper(
                          data: "Location",
                          font: poppins,
                          bold: true,
                          color: kcDarkGreyColor,
                          size: fontSize14),
                      const Icon(Icons.share)
                    ],
                  ),
                ),
              ),
              button_helper(
                  onpress: () async {
                    Map c = await ApiHelper.registerchat(
                        viewModel.sharedpref.readString('number'),
                        data['number']);
                    if (c['status']) {
                      viewModel.navigationService.navigateWithTransition(
                          ChatingView(
                            id: c['message'],
                            did: c['did'],
                          ),
                          routeName: Routes.chatingView,
                          transitionStyle: Transition.rightToLeft);
                    }
                  },
                  color: golden,
                  width: screenWidth(context),
                  child: text_helper(
                    data: "Let's Chat",
                    font: montserrat,
                    color: white,
                    size: fontSize14,
                    bold: true,
                  )),
              viewModel.dates.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        verticalSpaceSmall,
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: text_helper(
                              data: "Selected Date",
                              font: montserrat,
                              bold: true,
                              color: kcDarkGreyColor,
                              size: fontSize14),
                        ),
                        Container(
                          width: screenWidth(context),
                          height: screenHeightCustom(context, 0.09),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: getColorWithOpacity(kcLightGrey, 0.1)),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: viewModel.dates
                                .map<Widget>((e) => Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: text_helper(
                                            data: e.toString().substring(0, 10),
                                            font: montserrat,
                                            color: kcDarkGreyColor,
                                            size: fontSize14),
                                      )
                                    ]))
                                .toList(),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              Container(
                width: screenWidth(context),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: getColorWithOpacity(kcLightGrey, 0.1)),
                child: Column(
                  children: [
                    text_helper(
                        data: "Select you want to book bill board",
                        bold: true,
                        font: poppins,
                        color: kcDarkGreyColor,
                        size: fontSize14),
                    CalendarDatePicker2WithActionButtons(
                      config: CalendarDatePicker2WithActionButtonsConfig(
                        calendarType: CalendarDatePicker2Type.range,
                        selectedDayTextStyle: text_helper.customstyle(
                            poppins, white, fontSize12, context, false),
                        selectedDayHighlightColor: kcPrimaryColor,
                        centerAlignModePicker: true,
                        firstDate: DateTime.parse(data['avaliable']),
                      ),
                      value: viewModel.dates,
                      onValueChanged: (dates) => viewModel.selectedate(dates),
                    ),
                  ],
                ),
              ),
              button_helper(
                  onpress: () => viewModel.reviews(data),
                  color: red,
                  width: screenWidth(context),
                  child: text_helper(
                    data: "Reviews",
                    font: montserrat,
                    color: white,
                    size: fontSize14,
                    bold: true,
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: isadmin
          ? const SizedBox.shrink()
          : InkWell(
              onTap: () => viewModel.booknow(data, context),
              child: Container(
                height: 40,
                width: screenWidth(context),
                decoration: const BoxDecoration(
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_shopping_cart,
                      color: white,
                    ),
                    horizontalSpaceMedium,
                    text_helper(
                        data: "Book Now",
                        font: poppins,
                        bold: true,
                        color: white,
                        size: fontSize18),
                  ],
                ),
              ),
            ),
    );
  }

  Widget linerow(String text1, String text2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        text_helper(
          data: text1,
          font: poppins,
          color: kcDarkGreyColor,
          size: fontSize14,
          bold: true,
        ),
        horizontalSpaceSmall,
        Expanded(
          child: text_helper(
            data: text2,
            textAlign: TextAlign.start,
            font: poppins,
            color: kcDarkGreyColor,
            size: fontSize12,
          ),
        ),
      ],
    );
  }

  @override
  BookingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BookingViewModel();
}
