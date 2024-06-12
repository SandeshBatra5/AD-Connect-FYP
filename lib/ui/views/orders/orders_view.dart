// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/common/app_strings.dart';
import 'package:billboard/ui/common/ui_helpers.dart';
import 'package:billboard/ui/common/uihelper/button_helper.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:billboard/ui/widgets/common/top/top.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../common/apihelpers/apihelper.dart';
import '../../common/uihelper/snakbar_helper.dart';
import 'orders_viewmodel.dart';

class OrdersView extends StackedView<OrdersViewModel> {
  OrdersView({Key? key, required this.user}) : super(key: key);
  bool user;

  @override
  Widget builder(
    BuildContext context,
    OrdersViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Row(
            children: [
              Lottie.asset('assets/billborad.json',
                  width: screenWidthCustom(context, 0.15),
                  height: screenWidthCustom(context, 0.15)),
              text_helper(
                data: "Orders",
                font: montserrat,
                color: kcDarkGreyColor,
                size: fontSize20,
                bold: true,
              )
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                viewModel.notifyListeners();
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.refresh,
                  color: kcDarkGreyColor,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: user
                ? ApiHelper.getbyuser(viewModel.sharedpref.readString('number'))
                : ApiHelper.getbyrest(
                    viewModel.sharedpref.readString('number')),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.toString() == '[]') {
                  return Center(
                    child: text_helper(
                        data: "No Order available",
                        font: poppins,
                        color: kcDarkGreyColor,
                        size: fontSize14),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: screenWidth(context),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: snapshot.data[index]['status'] == 'new'
                                ? getColorWithOpacity(kcLightGrey, 0.2)
                                : getColorWithOpacity(red, 0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                              future: ApiHelper.getonuser(
                                  snapshot.data[index]['ownernumber']),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: snapshot.data['img'],
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            width: screenWidthCustom(
                                                context, 0.12),
                                            height: screenWidthCustom(
                                                context, 0.12),
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
                                            const Icon(
                                          Icons.error,
                                          color: kcDarkGreyColor,
                                        ),
                                      ),
                                      horizontalSpaceSmall,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                            verticalSpaceSmall,
                            FutureBuilder(
                              future: ApiHelper.billboardbyid(
                                  snapshot.data[index]['billboardid']),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      text_helper(
                                          data: snapshot.data['des'],
                                          bold: true,
                                          font: poppins,
                                          color: kcDarkGreyColor,
                                          size: fontSize16),
                                      FutureBuilder<String>(
                                        future: viewModel.loc(
                                            double.parse(snapshot.data['lat']),
                                            double.parse(snapshot.data['lon'])),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.hasData) {
                                            return text_helper(
                                                data: snapshot.data.toString(),
                                                font: poppins,
                                                color: kcDarkGreyColor,
                                                size: fontSize12);
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        },
                                      )
                                    ],
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                            verticalSpaceTiny,
                            Row(
                              children: [
                                horizontalSpaceSmall,
                                text_helper(
                                    data: "Status : ",
                                    font: montserrat,
                                    color: kcDarkGreyColor,
                                    bold: true,
                                    size: fontSize14),
                                text_helper(
                                    data: snapshot.data[index]['status'],
                                    font: montserrat,
                                    color: kcDarkGreyColor,
                                    size: fontSize14),
                              ],
                            ),
                            verticalSpaceTiny,
                            SizedBox(
                              width: screenWidth(context),
                              height: 40,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.of(snapshot.data[index]['date'])
                                    .map((e) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: kcPrimaryColor),
                                          child: Center(
                                              child: text_helper(
                                                  data: e,
                                                  font: poppins,
                                                  color: white,
                                                  size: fontSize14)),
                                        ))
                                    .toList(),
                              ),
                            ),
                            !user && snapshot.data[index]['status'] == 'new'
                                ? button_helper(
                                    onpress: () => viewModel.aspect(
                                        snapshot.data[index]['custnumber'],
                                        snapshot.data[index]['ownernumber'],
                                        context),
                                    color: red,
                                    width: screenWidth(context),
                                    child: text_helper(
                                        data: "Accept",
                                        font: montserrat,
                                        bold: true,
                                        color: white,
                                        size: fontSize14))
                                : const SizedBox.shrink(),
                          ],
                        ),
                      );
                    },
                  );
                }
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
        ));
  }

  @override
  OrdersViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OrdersViewModel();
}
