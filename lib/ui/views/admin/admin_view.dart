import 'package:billboard/ui/common/app_colors.dart';
import 'package:billboard/ui/common/app_strings.dart';
import 'package:billboard/ui/common/ui_helpers.dart';
import 'package:billboard/ui/common/uihelper/button_helper.dart';
import 'package:billboard/ui/common/uihelper/text_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../common/apihelpers/apihelper.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../../widgets/common/customslider/customslider.dart';
import 'admin_viewmodel.dart';

class AdminView extends StackedView<AdminViewModel> {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AdminViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Row(
            children: [
              Lottie.asset('assets/billborad.json',
                  width: screenWidthCustom(context, 0.15),
                  height: screenWidthCustom(context, 0.15)),
              horizontalSpaceSmall,
              text_helper(
                data: "Admin",
                font: poppins,
                color: kcPrimaryColor,
                size: fontSize14,
                bold: true,
              ),
            ],
          ),
          actions: [
            InkWell(
                onTap: () => viewModel.logout(),
                child: const Icon(Icons.logout)),
            horizontalSpaceSmall
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceSmall,
              SizedBox(
                width: screenWidth(context),
                height: screenHeightCustom(context, 0.17),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Container(
                                  width: screenWidth(context),
                                  height: screenHeightCustom(context, 0.9),
                                  color: white,
                                  child: FutureBuilder(
                                    future: ApiHelper.allusers(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
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
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                width: screenWidth(context),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: getColorWithOpacity(
                                                      kcVeryLightGrey, 0.5),
                                                ),
                                                child: Row(
                                                  children: [
                                                    CachedNetworkImage(
                                                      imageUrl: snapshot
                                                          .data[index]['img'],
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Container(
                                                          width:
                                                              screenWidthCustom(
                                                                  context,
                                                                  0.12),
                                                          height:
                                                              screenWidthCustom(
                                                                  context,
                                                                  0.12),
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          displaysimpleprogress(
                                                              context),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                        Icons.error,
                                                        color: kcDarkGreyColor,
                                                      ),
                                                    ),
                                                    horizontalSpaceSmall,
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          text_helper(
                                                              data:
                                                                  snapshot.data[
                                                                          index]
                                                                      ['name'],
                                                              bold: true,
                                                              font: poppins,
                                                              color:
                                                                  kcDarkGreyColor,
                                                              size: fontSize16),
                                                          text_helper(
                                                              data: snapshot
                                                                          .data[
                                                                      index]
                                                                  ['number'],
                                                              font: poppins,
                                                              color:
                                                                  kcDarkGreyColor,
                                                              size: fontSize12),
                                                          text_helper(
                                                              data: snapshot
                                                                      .data[
                                                                  index]['cat'],
                                                              font: poppins,
                                                              color:
                                                                  kcDarkGreyColor,
                                                              size: fontSize12),
                                                        ],
                                                      ),
                                                    ),
                                                    horizontalSpaceSmall,
                                                    InkWell(
                                                      onTap: () async {
                                                        bool c = await ApiHelper.deleteuser(
                                                            snapshot.data[index]
                                                                ['_id'],
                                                            snapshot.data[index]
                                                                        [
                                                                        'cat'] ==
                                                                    "user"
                                                                ? ""
                                                                : snapshot.data[
                                                                        index]
                                                                    ['number']);
                                                        if (c) {
                                                          show_snackbar(context,
                                                              "Deleted Successfully");
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    )
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
                                );
                              });
                        },
                        child: rbtn(context, "Users", "assets/person.png")),
                    InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Container(
                                  width: screenWidth(context),
                                  height: screenHeightCustom(context, 0.9),
                                  color: white,
                                  child: FutureBuilder(
                                    future: ApiHelper.allbillboardadmin(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data.toString() == '[]') {
                                          return Center(
                                            child: text_helper(
                                                data:
                                                    "Bill boards are \ncoming soon",
                                                font: poppins,
                                                color: kcDarkGreyColor,
                                                size: fontSize14),
                                          );
                                        } else {
                                          return ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return listdata(
                                                  snapshot.data[index],
                                                  context,
                                                  viewModel);
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
                                );
                              });
                        },
                        child:
                            rbtn(context, "Billboard", "assets/billboard.png")),
                    InkWell(
                        onTap: () => viewModel.allchats(),
                        child: rbtn(context, "Chats", "assets/chat.png")),
                  ],
                ),
              ),
              verticalSpaceMedium,
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: text_helper(
                    data: "All Orders",
                    bold: true,
                    font: poppins,
                    color: kcDarkGreyColor,
                    size: fontSize14),
              ),
              Expanded(
                child: FutureBuilder(
                  future: ApiHelper.allorder(),
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
                                                  displaysimpleprogress(
                                                      context),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: kcDarkGreyColor,
                                              ),
                                            ),
                                            horizontalSpaceSmall,
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                    data:
                                                        snapshot.data['number'],
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
                                                  double.parse(
                                                      snapshot.data['lat']),
                                                  double.parse(
                                                      snapshot.data['lon'])),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  return text_helper(
                                                      data: snapshot.data
                                                          .toString(),
                                                      font: poppins,
                                                      color: kcDarkGreyColor,
                                                      size: fontSize12);
                                                } else {
                                                  return const SizedBox
                                                      .shrink();
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
                                      children: List.of(
                                              snapshot.data[index]['date'])
                                          .map((e) => Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
              )
            ],
          ),
        ));
  }

  Widget rbtn(BuildContext context, String text, String img) {
    return Container(
      width: 110,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            img,
            width: 50,
            height: 50,
          ),
          verticalSpaceTiny,
          text_helper(
            data: text,
            font: poppins,
            color: kcDarkGreyColor,
            size: fontSize14,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget listdata(Map data, BuildContext context, AdminViewModel viewModel) {
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
                            InkWell(
                              onTap: () async {
                                bool c = await ApiHelper.deletebillboard(
                                    data['_id'], context);
                                if (c) {
                                  show_snackbar(
                                      context, "Deleted Successfully");
                                }
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  verticalSpaceSmall,
                  linerow("Status", data['status']),
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
                  ),
                  verticalSpaceSmall,
                  data['status'] == "new"
                      ? Row(
                          children: [
                            button_helper(
                                onpress: () => viewModel.approve(
                                    "approve", data['_id'], context),
                                color: Colors.green,
                                width: screenWidthCustom(context, 0.3),
                                child: text_helper(
                                    data: "Approve",
                                    font: poppins,
                                    color: white,
                                    size: fontSize14,
                                    bold: true)),
                            button_helper(
                                onpress: () => viewModel.approve(
                                    "reject", data['_id'], context),
                                color: Colors.red,
                                width: screenWidthCustom(context, 0.3),
                                child: text_helper(
                                    data: "Reject",
                                    font: poppins,
                                    color: white,
                                    size: fontSize14,
                                    bold: true)),
                          ],
                        )
                      : const SizedBox.shrink()
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
  AdminViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminViewModel();
}
