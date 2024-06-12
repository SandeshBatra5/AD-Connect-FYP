import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/apihelpers/apihelper.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../../common/uihelper/text_helper.dart';
import '../../widgets/common/top/top.dart';
import 'wallet_viewmodel.dart';

class WalletView extends StackedView<WalletViewModel> {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WalletViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Column(
            children: [
              Top(txt: "Wallet"),
              Expanded(
                child: FutureBuilder(
                  future: ApiHelper.getwallet(
                      viewModel.sharedpref.readString('number')),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      viewModel.populate(snapshot.data!['rest']);
                      return ListView(
                        children: [
                          top(context, snapshot.data!['rest']['paid'], "Paid"),
                          top(context, snapshot.data!['rest']['topup'],
                              "Top Up"),
                          top(context, snapshot.data!['rest']['notpay'],
                              "Not Pay"),
                          SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              borderWidth: 4,
                              plotAreaBorderWidth: 0,
                              title: ChartTitle(
                                  text: "Wallet",
                                  textStyle: text_helper.customstyle(
                                      poppins,
                                      kcDarkGreyColor,
                                      fontSize12,
                                      context,
                                      true)),
                              primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: viewModel.max,
                                  interval: 100),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<ChartData, String>>[
                                ColumnSeries<ChartData, String>(
                                    dataSource: viewModel.histogramData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    name:
                                        viewModel.sharedpref.readString('name'),
                                    color:
                                        getColorWithOpacity(kcPrimaryColor, 1))
                              ])
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
              )
            ],
          ),
        ));
  }

  Widget top(BuildContext context, String data, String title) {
    return Container(
      width: screenWidth(context),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getColorWithOpacity(kcLightGrey, 0.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text_helper(
                data: title,
                font: poppins,
                color: kcDarkGreyColor,
                size: fontSize14,
                bold: true,
              ),
              text_helper(
                data: data,
                font: poppins,
                color: kcLightGrey,
                size: fontSize12,
              ),
            ],
          ),
          const Icon(Icons.paypal)
        ],
      ),
    );
  }

  @override
  WalletViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      WalletViewModel();
}
