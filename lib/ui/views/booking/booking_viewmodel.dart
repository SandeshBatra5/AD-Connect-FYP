// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:billboard/ui/common/apihelpers/firebsaeuploadhelper.dart';
import 'package:billboard/ui/views/reviews/reviews_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:http/http.dart" as http;

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/apihelpers/apihelper.dart';
import '../../common/uihelper/snakbar_helper.dart';

class BookingViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final sharedpref = locator<SharedprefService>();

  Future<void> openmap(BuildContext context, String toLat, String toLng) async {
    displayprogress(context);
    Position p = await location();
    hideprogress(context);
    if (!await launchUrl(
        Uri.parse("https://www.google.com/maps/dir/?api=1&origin=${p.latitude},"
            "${p.longitude}&destination=$toLat,$toLng"))) {
      show_snackbar(context, "Can not open now");
    }
  }

  Future<Position> location() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Map<String, dynamic>? paymentIntent;
  createPaymentIntent(String amnount) async {
    try {
      Map<String, dynamic> body = {
        'amount': (int.parse(amnount) * 100).toString(),
        'currency': 'USD',
      };
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51PAzxA07Ok4Rl8ZFS7PWTA1zIgg8Y86p2VX0UR8OjEgARGjBYEzEWGELxFyMvn9wWta4yk8L8qvhu0wHGF3kNUto00xpGmEUBt',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return json.decode(response.body);
    } catch (e) {
      print("failing : " + e.toString());
    }
  }

  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      print("fail : " + e.toString());
      return false;
    }
  }

  Future<bool> makePayment(String amnount) async {
    try {
      paymentIntent = await createPaymentIntent(amnount);
      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: 'US',
        currencyCode: 'USD',
        testEnv: true,
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: "Sabir",
          googlePay: gpay,
        ),
      );
      bool c = await displayPaymentSheet();
      return c;
    } catch (e) {
      print("failed : " + e.toString());
      return false;
    }
  }

  Future<void> booknow(Map data, BuildContext context) async {
    if (dates.isEmpty) {
      show_snackbar(context, "");
    } else {
      bool c = await makePayment(data['price']);
      if (!c) {
        show_snackbar(context, "Unsuccessful");
      } else {
        String number = data['number'];
        displayprogress(context);
        Map wdata = await ApiHelper.getwallet(sharedpref.readString('number'));
        if (wdata['status']) {
          Map rdata = await ApiHelper.getwallet(number);
          int price = int.parse(data['price']);
          List<String> d = [];
          for (var element in dates) {
            d.add(element.toString().substring(0, 10));
          }
          bool ru = await ApiHelper.updatewallet(
              number,
              rdata['rest']['notpay'],
              rdata['rest']['paid'],
              "${int.parse(rdata['rest']['topup']) + price}",
              context);
          if (ru) {
            wdata = await ApiHelper.getwallet(sharedpref.readString('number'));
            bool uw = await ApiHelper.updatewallet(
                sharedpref.readString('number'),
                wdata['rest']['notpay'],
                "${int.parse(wdata['rest']['paid']) + price}",
                wdata['rest']['topup'],
                context);
            if (uw) {
              bool result = await ApiHelper.ordergistration(data['_id'],
                  sharedpref.readString('number'), number, d, context);
              if (result) {
                Map datau = await ApiHelper.getonuser(data['number']);
                await FirebaseHelper.sendnotificationto(
                    datau['deviceid'], "New Order", "Accept New Order Now");
                await ApiHelper.billboardupdateavaliable(
                    data['_id'], d[1], context);
                hideprogress(context);
                navigationService.back();
                navigationService.back();
                notifyListeners();
              }
            }
          }
        }
      }
    }
  }

  List<DateTime?> dates = [];
  void selectedate(List<DateTime?> date) {
    dates = date;
    notifyListeners();
  }

  void reviews(Map data) {
    navigationService.navigateWithTransition(
        ReviewsView(
          data: data,
        ),
        routeName: Routes.reviewsView,
        transitionStyle: Transition.rightToLeft);
  }
}
