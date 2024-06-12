// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:billboard/ui/common/uihelper/button_helper.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:billboard/ui/common/uihelper/text_veiw_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/common/ui_helpers.dart';

import '../../common/apihelpers/apihelper.dart';
import '../../common/app_strings.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../../widgets/common/customslider/customslider.dart';
import '../../widgets/common/tophelper/tophelper.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidthCustom(context, 0.9),
                  child: OutlineSearchBar(
                    margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    backgroundColor: white,
                    borderRadius: BorderRadius.circular(10),
                    borderColor: kcVeryLightGrey,
                    borderWidth: 2,
                    cursorColor: kcPrimaryColor,
                    clearButtonColor: kcPrimaryColor,
                    clearButtonIconColor: white,
                    hintText: "Search here",
                    ignoreSpecialChar: true,
                    searchButtonIconColor: kcPrimaryColor,
                    hintStyle: text_helper.customstyle(
                        poppins, kcLightGrey, fontSize12, context, false),
                    textStyle: text_helper.customstyle(
                        poppins, kcPrimaryColor, fontSize12, context, true),
                    textEditingController: viewModel.search,
                    onKeywordChanged: (String val) {
                      viewModel.notifyListeners();
                    },
                  )
                      .animate()
                      .fade(delay: 700.milliseconds)
                      .moveY(begin: 50, end: 0),
                ),
                InkWell(
                  onTap: () => filterdialog(context, viewModel),
                  child: const Icon(
                    Icons.filter_alt_rounded,
                    size: 30,
                  )
                      .animate()
                      .fade(delay: 700.milliseconds)
                      .moveY(begin: 50, end: 0),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: ApiHelper.allbillboard(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.toString() == '[]') {
                      return Center(
                        child: text_helper(
                            data: "Bill boards are \ncoming soon",
                            font: poppins,
                            color: kcDarkGreyColor,
                            size: fontSize14),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (viewModel.applyfil) {
                            return pricefilter(
                                viewModel, context, snapshot, index);
                          } else {
                            return companyfilter(
                                viewModel, context, snapshot, index);
                          }
                        },
                      );
                    }
                  } else if (snapshot.hasError) {
                    return const Icon(
                      Icons.error,
                      color: kcPrimaryColor,
                    );
                  } else {
                    return displaysimpleprogress(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pricefilter(HomeViewModel viewModel, BuildContext context,
      AsyncSnapshot snapshot, int index) {
    if (viewModel.prizes.text.isEmpty && viewModel.prizee.text.isEmpty) {
      return heightfilter(viewModel, context, snapshot, index);
    } else if (viewModel.prizes.text.isNotEmpty &&
        viewModel.prizee.text.isEmpty) {
      if (int.parse(snapshot.data[index]['price']) >=
          int.parse(viewModel.prizes.text)) {
        return heightfilter(viewModel, context, snapshot, index);
      } else {
        return const SizedBox.shrink();
      }
    } else if (viewModel.prizes.text.isEmpty &&
        viewModel.prizee.text.isNotEmpty) {
      if (int.parse(snapshot.data[index]['price']) <=
          int.parse(viewModel.prizee.text)) {
        return heightfilter(viewModel, context, snapshot, index);
      } else {
        return const SizedBox.shrink();
      }
    } else {
      if (int.parse(snapshot.data[index]['price']) <=
              int.parse(viewModel.prizee.text) &&
          (int.parse(snapshot.data[index]['price']) >=
              int.parse(viewModel.prizes.text))) {
        return heightfilter(viewModel, context, snapshot, index);
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget heightfilter(HomeViewModel viewModel, BuildContext context,
      AsyncSnapshot snapshot, int index) {
    if (viewModel.height.text.isEmpty && viewModel.heighte.text.isEmpty) {
      return widthfilter(viewModel, context, snapshot, index);
    } else if (viewModel.height.text.isNotEmpty &&
        viewModel.heighte.text.isEmpty) {
      if (int.parse(snapshot.data[index]['height']) >=
          int.parse(viewModel.height.text)) {
        return widthfilter(viewModel, context, snapshot, index);
      } else {
        return const SizedBox.shrink();
      }
    } else if (viewModel.height.text.isEmpty &&
        viewModel.heighte.text.isNotEmpty) {
      if (int.parse(snapshot.data[index]['height']) <=
          int.parse(viewModel.heighte.text)) {
        return widthfilter(viewModel, context, snapshot, index);
      } else {
        return const SizedBox.shrink();
      }
    } else {
      if (int.parse(snapshot.data[index]['height']) <=
              int.parse(viewModel.heighte.text) &&
          (int.parse(snapshot.data[index]['height']) >=
              int.parse(viewModel.height.text))) {
        return widthfilter(viewModel, context, snapshot, index);
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget widthfilter(HomeViewModel viewModel, BuildContext context,
      AsyncSnapshot snapshot, int index) {
    if (viewModel.width.text.isEmpty && viewModel.widthe.text.isEmpty) {
      return companyfilter(viewModel, context, snapshot, index);
    } else if (viewModel.width.text.isNotEmpty &&
        viewModel.widthe.text.isEmpty) {
      if (int.parse(snapshot.data[index]['width']) >=
          int.parse(viewModel.width.text)) {
        return companyfilter(viewModel, context, snapshot, index);
      } else {
        return const SizedBox.shrink();
      }
    } else if (viewModel.width.text.isEmpty &&
        viewModel.widthe.text.isNotEmpty) {
      if (int.parse(snapshot.data[index]['width']) <=
          int.parse(viewModel.widthe.text)) {
        return companyfilter(viewModel, context, snapshot, index);
      } else {
        return const SizedBox.shrink();
      }
    } else {
      if (int.parse(snapshot.data[index]['width']) <=
              int.parse(viewModel.widthe.text) &&
          (int.parse(snapshot.data[index]['width']) >=
              int.parse(viewModel.width.text))) {
        return companyfilter(viewModel, context, snapshot, index);
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget companyfilter(HomeViewModel viewModel, BuildContext context,
      AsyncSnapshot snapshot, int index) {
    if (viewModel.search.text.isEmpty) {
      return listdata(snapshot.data[index], context, viewModel);
    } else {
      if (snapshot.data[index]['des']
          .toString()
          .toLowerCase()
          .contains(viewModel.search.text.toLowerCase())) {
        return listdata(snapshot.data[index], context, viewModel);
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  void filterdialog(BuildContext context, HomeViewModel viewModel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              color: white,
              child: ListView(
                shrinkWrap: true,
                children: [
                  text_helper(
                    data: "Width",
                    font: montserrat,
                    color: kcPrimaryColor,
                    size: fontSize16,
                    bold: true,
                  ),
                  text_view_helper(
                    hint: "Width Start",
                    controller: viewModel.width,
                    showicon: true,
                    icon: const Icon(Icons.photo_size_select_large_rounded),
                  ),
                  text_view_helper(
                    hint: "Width End",
                    controller: viewModel.widthe,
                    showicon: true,
                    icon: const Icon(Icons.photo_size_select_large_rounded),
                  ),
                  text_helper(
                    data: "Height",
                    font: montserrat,
                    color: kcPrimaryColor,
                    size: fontSize16,
                    bold: true,
                  ),
                  text_view_helper(
                    hint: "Height Start",
                    controller: viewModel.height,
                    showicon: true,
                    icon: const Icon(Icons.photo_size_select_large_rounded),
                  ),
                  text_view_helper(
                    hint: "Height End",
                    controller: viewModel.heighte,
                    showicon: true,
                    icon: const Icon(Icons.photo_size_select_large_rounded),
                  ),
                  text_helper(
                    data: "Price",
                    font: montserrat,
                    color: kcPrimaryColor,
                    size: fontSize16,
                    bold: true,
                  ),
                  text_view_helper(
                    hint: "Price Start",
                    controller: viewModel.prizes,
                    showicon: true,
                    icon: const Icon(Icons.price_change),
                  ),
                  text_view_helper(
                    hint: "Price End",
                    controller: viewModel.prizee,
                    showicon: true,
                    icon: const Icon(Icons.price_change),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: button_helper(
                            onpress: () => viewModel.applyfilter(),
                            color: kcPrimaryColor,
                            width: screenHeightCustom(context, 0.2),
                            child: text_helper(
                                data: "Apply",
                                font: montserrat,
                                color: white,
                                size: fontSize14)),
                      ),
                      viewModel.applyfil
                          ? Expanded(
                              child: button_helper(
                                  onpress: () => viewModel.canclefilter(),
                                  color: kcPrimaryColor,
                                  width: screenHeightCustom(context, 0.2),
                                  child: text_helper(
                                      data: "Cancel All",
                                      font: montserrat,
                                      color: white,
                                      size: fontSize14)),
                            )
                          : const SizedBox.shrink(),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Drawer drawer(HomeViewModel viewModel) {
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
                      function: () => viewModel.wishlist(),
                      txt: "Wish List",
                      icon: Icons.star_border)
                  .animate()
                  .fade(delay: 1900.milliseconds)
                  .moveY(begin: 50, end: 0),
              Tophelper(
                      function: () => viewModel.allchats(),
                      txt: "All Chats",
                      icon: Icons.chat)
                  .animate()
                  .fade(delay: 2100.milliseconds)
                  .moveY(begin: 50, end: 0),
              Tophelper(
                      function: () => viewModel.logout(),
                      txt: "Logout",
                      icon: Icons.logout)
                  .animate()
                  .fade(delay: 2300.milliseconds)
                  .moveY(begin: 50, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget listdata(Map data, BuildContext context, HomeViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.booking(data),
      child: Container(
        width: screenWidth(context),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Customslider(data: data['image']),
            Container(
              decoration: BoxDecoration(
                  color: getColorWithOpacity(golden, 0.01),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpaceSmall,
                  FutureBuilder(
                    future: ApiHelper.getonuser(data['number']),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: snapshot.data['img'],
                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
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
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              ),
                            ),
                            horizontalSpaceSmall,
                            FutureBuilder(
                              future: ApiHelper.wishlistbyuser(
                                  viewModel.sharedpref.readString('number'),
                                  data['_id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.toString() == '{}') {
                                    return InkWell(
                                      onTap: () => viewModel.registerwishlist(
                                          context,
                                          viewModel.sharedpref
                                              .readString('number'),
                                          data['_id']),
                                      child: const Icon(
                                        Icons.star_border,
                                        color: golden,
                                      ),
                                    );
                                  } else {
                                    return InkWell(
                                      onTap: () => viewModel.deletewishlist(
                                          context, snapshot.data['_id']),
                                      child: const Icon(
                                        Icons.star,
                                        color: golden,
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
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  verticalSpaceSmall,
                  linerow("Size", data['width'] + "x" + data['height']),
                  linerow("price", "\$" + data['price']),
                  linerow("Description", data['des']),
                  linerow("Avaliable", data['avaliable']),
                  FutureBuilder<String>(
                    future: viewModel.loc(
                        double.parse(data['lat']), double.parse(data['lon'])),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return linerow("Location", snapshot.data.toString());
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  )
                ],
              ),
            )
          ],
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
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
