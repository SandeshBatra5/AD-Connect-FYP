import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/apihelpers/apihelper.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_strings.dart';
import '../../../common/ui_helpers.dart';
import '../../../common/uihelper/text_helper.dart';
import 'allchats_viewmodel.dart';

class AllchatsView extends StackedView<AllchatsViewModel> {
  const AllchatsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllchatsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: kcPrimaryColor,
          iconTheme: const IconThemeData(color: white),
          title: text_helper(
            data: "All Chat",
            font: poppins,
            color: white,
            size: fontSize14,
            bold: true,
          ),
        ),
        body: FutureBuilder(
          future:
              ApiHelper.allchatbydid(viewModel.sharedpref.readString("number")),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.toString() == '[]') {
                return const Center(
                  child: Text("No Data"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => viewModel.move(snapshot.data[index]['_id'],
                          snapshot.data[index]['did']),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green[100],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            snapshot.data[index]['uid'] == "0000-0000000"
                                ? text_helper(
                                    data: "Admin",
                                    font: montserrat,
                                    color: kcDarkGreyColor,
                                    size: fontSize14,
                                    bold: true,
                                  )
                                : FutureBuilder(
                                    future: ApiHelper.getonuser(
                                        snapshot.data[index]['uid']),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot2) {
                                      if (snapshot2.hasData) {
                                        return text_helper(
                                          data:
                                              snapshot2.data['name'].toString(),
                                          font: montserrat,
                                          color: kcDarkGreyColor,
                                          size: fontSize14,
                                          bold: true,
                                        );
                                      } else if (snapshot2.hasError) {
                                        return const Icon(
                                          Icons.error,
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    },
                                  ),
                            text_helper(
                                data: snapshot.data[index]['date']
                                    .toString()
                                    .substring(0, 10),
                                font: montserrat,
                                color: kcDarkGreyColor,
                                size: fontSize10),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return const Icon(
                Icons.error,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }

  @override
  AllchatsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllchatsViewModel();
}
