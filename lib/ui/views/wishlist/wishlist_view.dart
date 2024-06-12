import 'package:billboard/ui/common/apihelpers/apihelper.dart';
import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/widgets/common/top/top.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../../common/uihelper/text_helper.dart';
import '../../widgets/common/customslider/customslider.dart';
import 'wishlist_viewmodel.dart';

class WishlistView extends StackedView<WishlistViewModel> {
  const WishlistView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WishlistViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Column(
            children: [
              Top(txt: "Wish List"),
              Expanded(
                child: FutureBuilder(
                  future: ApiHelper.wishlistbynumber(
                      viewModel.sharedpref.readString('number')),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.toString() == '[]') {
                        return Center(
                          child: text_helper(
                              data: "No Data",
                              font: poppins,
                              color: kcDarkGreyColor,
                              size: fontSize14),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return listdata(
                                snapshot.data[index], context, viewModel);
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
              )
            ],
          ),
        ));
  }

  Widget listdata(Map data, BuildContext context, WishlistViewModel viewModel) {
    return FutureBuilder(
      future: ApiHelper.billboardbyid(data['billboardid']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.toString() == '{}') {
            return Center(
              child: text_helper(
                  data: "No Data",
                  font: poppins,
                  color: kcDarkGreyColor,
                  size: fontSize14),
            );
          } else {
            return listdataa(snapshot.data, context, viewModel);
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
    );
  }

  Widget listdataa(
      Map data, BuildContext context, WishlistViewModel viewModel) {
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
  WishlistViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      WishlistViewModel();
}
