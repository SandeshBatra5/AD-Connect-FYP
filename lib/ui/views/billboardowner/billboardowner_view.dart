// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:billboard/ui/common/app_strings.dart';
import 'package:billboard/ui/common/ui_helpers.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:billboard/ui/widgets/common/customslider/customslider.dart';
import 'package:billboard/ui/widgets/common/tophelper/tophelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../common/apihelpers/apihelper.dart';
import '../../common/app_colors.dart';
import '../../common/uihelper/snakbar_helper.dart';
import 'billboardowner_viewmodel.dart';

class BillboardownerView extends StackedView<BillboardownerViewModel> {
  const BillboardownerView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BillboardownerViewModel viewModel,
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
              data: viewModel.sharedpref.readString('name'),
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
      drawer: drawer(viewModel),
      body: SafeArea(
        child: FutureBuilder(
          future: ApiHelper.billboardbynumber(
              viewModel.sharedpref.readString('number')),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.toString() != '[]') {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => viewModel.upload(snapshot.data[index], true),
                      child: Container(
                        width: screenWidth(context),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Customslider(data: snapshot.data[index]['image']),
                            Container(
                              decoration: BoxDecoration(
                                  color: getColorWithOpacity(golden, 0.01),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  linerow("status", snapshot.data[index]['status']),
                                  linerow(
                                      "Size",
                                      snapshot.data[index]['width'] +
                                          "x" +
                                          snapshot.data[index]['height']),
                                  linerow("price",
                                      "\$" + snapshot.data[index]['price']),
                                  linerow("Description",
                                      snapshot.data[index]['des']),
                                  linerow("Avaliable",
                                      snapshot.data[index]['avaliable']),
                                  FutureBuilder<String>(
                                    future: viewModel.loc(
                                        double.parse(
                                            snapshot.data[index]['lat']),
                                        double.parse(
                                            snapshot.data[index]['lon'])),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if (snapshot.hasData) {
                                        return linerow("Location",
                                            snapshot.data.toString());
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: screenWidth(context),
                              height: 1,
                              color: kcDarkGreyColor,
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            )
                          ],
                        ),
                      )
                          .animate()
                          .fade(delay: (500 * (index * 10)).milliseconds)
                          .moveY(begin: 50, end: 0),
                    );
                  },
                );
              } else {
                return Center(
                  child: InkWell(
                    onTap: () => viewModel.upload({}, false),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        text_helper(
                            data: "No Data",
                            font: poppins,
                            color: kcDarkGreyColor,
                            size: fontSize14),
                        text_helper(
                            data: "Click here to add data",
                            font: poppins,
                            color: kcLightGrey,
                            size: fontSize12),
                      ],
                    ),
                  ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.upload({}, false),
        backgroundColor: kcPrimaryColor,
        child: const Icon(
          Icons.add,
          size: 50,
          color: white,
        ),
      ),
    );
  }

  Drawer drawer(BillboardownerViewModel viewModel) {
    return Drawer(
      backgroundColor: white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: viewModel.sharedpref.readString('img'),
                  imageBuilder: (context, imageProvider) => Container(
                    width: screenWidthCustom(context, 0.25),
                    height: screenWidthCustom(context, 0.25),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => displaysimpleprogress(context),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: kcDarkGreyColor,
                  ),
                ),
              ),
              verticalSpaceMedium,
              text_helper(
                data: 'name',
                font: poppins,
                color: kcDarkGreyColor,
                size: fontSize14,
                bold: true,
              )
                  .animate()
                  .fade(delay: 500.milliseconds)
                  .moveY(begin: 50, end: 0),
              text_helper(
                      data: viewModel.sharedpref.readString('name'),
                      font: poppins,
                      color: kcDarkGreyColor,
                      size: fontSize14)
                  .animate()
                  .fade(delay: 500.milliseconds)
                  .moveY(begin: 50, end: 0),
              text_helper(
                data: 'number',
                font: poppins,
                color: kcDarkGreyColor,
                size: fontSize14,
                bold: true,
              )
                  .animate()
                  .fade(delay: 700.milliseconds)
                  .moveY(begin: 50, end: 0),
              text_helper(
                      data: viewModel.sharedpref.readString('number'),
                      font: poppins,
                      color: kcDarkGreyColor,
                      size: fontSize14)
                  .animate()
                  .fade(delay: 700.milliseconds)
                  .moveY(begin: 50, end: 0),
              text_helper(
                data: 'cnic',
                font: poppins,
                color: kcDarkGreyColor,
                size: fontSize14,
                bold: true,
              )
                  .animate()
                  .fade(delay: 900.milliseconds)
                  .moveY(begin: 50, end: 0),
              text_helper(
                      data: viewModel.sharedpref.readString('cnic'),
                      font: poppins,
                      color: kcDarkGreyColor,
                      size: fontSize14)
                  .animate()
                  .fade(delay: 900.milliseconds)
                  .moveY(begin: 50, end: 0),
              text_helper(
                data: 'address',
                font: poppins,
                color: kcDarkGreyColor,
                size: fontSize14,
                bold: true,
              )
                  .animate()
                  .fade(delay: 1100.milliseconds)
                  .moveY(begin: 50, end: 0),
              text_helper(
                      data: viewModel.sharedpref.readString('address'),
                      font: poppins,
                      color: kcDarkGreyColor,
                      size: fontSize14)
                  .animate()
                  .fade(delay: 1100.milliseconds)
                  .moveY(begin: 50, end: 0),
              text_helper(
                data: 'dob',
                font: poppins,
                color: kcDarkGreyColor,
                size: fontSize14,
                bold: true,
              )
                  .animate()
                  .fade(delay: 1300.milliseconds)
                  .moveY(begin: 50, end: 0),
              text_helper(
                      data: viewModel.sharedpref.readString('dob'),
                      font: poppins,
                      color: kcDarkGreyColor,
                      size: fontSize14)
                  .animate()
                  .fade(delay: 1300.milliseconds)
                  .moveY(begin: 50, end: 0),
              verticalSpaceMedium,
              Tophelper(
                      function: () => viewModel.wallet(),
                      txt: "Wallet",
                      icon: Icons.wallet)
                  .animate()
                  .fade(delay: 1500.milliseconds)
                  .moveY(begin: 50, end: 0),
              Tophelper(
                      function: () => viewModel.order(),
                      txt: "Order",
                      icon: Icons.bookmark_border)
                  .animate()
                  .fade(delay: 1700.milliseconds)
                  .moveY(begin: 50, end: 0),
              Tophelper(
                      function: () => viewModel.allchats(),
                      txt: "All Chats",
                      icon: Icons.chat)
                  .animate()
                  .fade(delay: 1900.milliseconds)
                  .moveY(begin: 50, end: 0),
              Tophelper(
                      function: () => viewModel.logout(),
                      txt: "Logout",
                      icon: Icons.logout)
                  .animate()
                  .fade(delay: 2100.milliseconds)
                  .moveY(begin: 50, end: 0),
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
  void onViewModelReady(BillboardownerViewModel viewModel) => viewModel.first();

  @override
  BillboardownerViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BillboardownerViewModel();
}
