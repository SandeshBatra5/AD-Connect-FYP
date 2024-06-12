import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/sharedpref_service.dart';

class WalletViewModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();

  final List<ChartData> histogramData = <ChartData>[];
  double max = 0;
  void populate(Map data) {
    max = double.parse(data['notpay']) +
        int.parse(data['paid']) +
        int.parse(data['topup']);
    histogramData.add(ChartData("Not Pay", double.parse(data['notpay'])));
    histogramData.add(ChartData("Paid", double.parse(data['paid'])));
    histogramData.add(ChartData("Top Up", double.parse(data['topup'])));
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
