// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:billboard/ui/common/apihelpers/firebsaeuploadhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../app/app.locator.dart';
import '../../../services/sharedpref_service.dart';
import '../uihelper/snakbar_helper.dart';

const url = 'http://192.168.47.237:3000/';
//const url = 'http://10.0.2.2:3000/';
const registrationlink = "${url}register";
const loginlink = "${url}login";
const getonuserlink = "${url}getonuser";
const alluserslink = "${url}allusers";
const deleteuserlink = "${url}deleteuser";
const updateoflink = "${url}updateof";

// billboard
const registerbillboardlink = "${url}registerbillboard";
const billboardbynumberlink = "${url}billboardbynumber";
const allbillboardlink = "${url}allbillboard";
const updatebillboardlink = "${url}updatebillboard";
const billboardbyidlink = "${url}billboardbyid";
const billboardupdateavaliablelink = "${url}billboardupdateavaliable";
const deletebillboardlink = "${url}deletebillboard";
const updatedbillboardratinglink = "${url}updatedbillboardrating";
const allbillboardadminlink = "${url}allbillboardadmin";
const updatebillboardstatuslink = "${url}updatebillboardstatus";

// order
const registeroderlink = "${url}registeroder";
const getbyrestlink = "${url}getbyrest";
const getbyuserlink = "${url}getbyuser";
const updatestatuslink = "${url}updatestatus";
const allorderlink = "${url}allorder";

// wallet
const registerwalletlink = "${url}registerwallet";
const getwalletlink = "${url}getwallet";
const updatewalletlink = "${url}updatewallet";

// wishlist
const registerwishlistlink = "${url}registerwishlist";
const wishlistbyuserlink = "${url}wishlistbyuser";
const wishlistbynumberlink = "${url}wishlistbynumber";
const wishlistdeletelink = "${url}wishlistdelete";

// chat
const registerchatlink = "${url}registerchat";
const allchatbyidlink = "${url}allchatbyid";
const addchatlink = "${url}addchat";
const allchatbydidlink = "${url}allchatbydid";

class ApiHelper {
  static final sharedpref = locator<SharedprefService>();

  // chat
  static Future<Map> registerchat(String uid, String did) async {
    try {
      var response = await http.post(Uri.parse(registerchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "did": did,
            "c": [],
            "date": DateTime.now().toString(),
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> allchatbyid(String id) async {
    try {
      var response = await http.post(Uri.parse(allchatbyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<List> allchatbydid(String did) async {
    try {
      var response = await http.post(Uri.parse(allchatbydidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"did": did}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addchat(String id, Map dataa, String sendto) async {
    try {
      var response = await http.post(Uri.parse(addchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "data": dataa}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      Map d = await getonuser(sendto);
      await FirebaseHelper.sendnotificationto(
          d['deviceid'], "New Message", dataa['mess']);
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // auth
  static Future<bool> registration(
      String name,
      String cnic,
      String number,
      String address,
      String dob,
      String cat,
      String img,
      String pass,
      String deviceid,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registrationlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": name,
            "cnic": cnic,
            "number": number,
            "address": address,
            "dob": dob,
            "cat": cat,
            "img": img,
            "pass": pass,
            "deviceid": deviceid,
            "of": "offline",
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'tryagainlater');
      return false;
    }
  }

  static Future<Map> login(
      String number, String pass, String deviceid, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(loginlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"number": number, "pass": pass, "deviceid": deviceid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (data['status']) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(data['token']);
        return decodedToken;
      } else {
        hideprogress(context);
        show_snackbar(context, data['message']);
        return {};
      }
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return {};
    }
  }

  static Future<Map> getonuser(String number) async {
    try {
      var response = await http.post(
        Uri.parse(getonuserlink),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"number": number}),
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['user'];
    } catch (e) {
      return {};
    }
  }

  static Future<bool> updateof(String number,String of) async {
    try {
      var response = await http.post(
        Uri.parse(updateoflink),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"number": number,"of":of}),
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteuser(String id, String number) async {
    try {
      var response = await http.post(
        Uri.parse(deleteuserlink),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id, "number": number}),
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<List> allusers() async {
    try {
      var response = await http.post(Uri.parse(alluserslink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['user'];
    } catch (e) {
      return [];
    }
  }

  // billboard
  static Future<bool> registerbillboard(
      String number,
      String price,
      String width,
      String height,
      String lon,
      String lat,
      String des,
      String avaliable,
      List image,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerbillboardlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "price": price,
            "width": width,
            "height": height,
            "lon": lon,
            "lat": lat,
            "des": des,
            "avaliable": avaliable,
            "image": image,
            "itemrating":"0",
            "itemuser":"0",
            "reviews":[],
            "status":"new"
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> updatedbillboardrating(
      String id, double itemrating, Map rdata, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatedbillboardratinglink),
          headers: {"Content-Type": "application/json"},
          body:
          jsonEncode({"id": id, "itemrating": itemrating, "rdata": rdata}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['message']);
      return data['status'] as bool;
    } catch (e) {
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<List> billboardbynumber(String number) async {
    try {
      var response = await http.post(
        Uri.parse(billboardbynumberlink),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"number": number}),
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> allbillboard() async {
    try {
      var response = await http.post(
        Uri.parse(allbillboardlink),
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> allbillboardadmin() async {
    try {
      var response = await http.post(
        Uri.parse(allbillboardadminlink),
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> updatebillboard(
      String id,
      String price,
      String width,
      String height,
      String lon,
      String lat,
      String des,
      String avaliable,
      List image,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatebillboardlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "price": price,
            "width": width,
            "height": height,
            "lon": lon,
            "lat": lat,
            "des": des,
            "avaliable": avaliable,
            "image": image
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> updatebillboardstatus(
      String id,
      String status,
      BuildContext context) async {
    try {
      displayprogress(context);
      var response = await http.post(Uri.parse(updatebillboardstatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "status": status
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      hideprogress(context);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> billboardupdateavaliable(
      String id, String avaliable, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(billboardupdateavaliablelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "avaliable": avaliable,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> deletebillboard(String id, BuildContext context) async {
    try {
      displayprogress(context);
      var response = await http.post(Uri.parse(deletebillboardlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      hideprogress(context);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  // order
  static Future<bool> ordergistration(String billboardid, String custnumber,
      String ownernumber, List date, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registeroderlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "billboardid": billboardid,
            "custnumber": custnumber,
            "ownernumber": ownernumber,
            "date": date,
            "status": "new"
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> updatestatus(
      String custnumber, String ownernumber, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatestatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "custnumber": custnumber,
            "ownernumber": ownernumber,
            "status": "aspected"
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['message']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<List> getbyrest(String ownernumber) async {
    try {
      var response = await http.post(Uri.parse(getbyrestlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"ownernumber": ownernumber}));
      return jsonDecode(utf8.decode(response.bodyBytes))['rest'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<List> getbyuser(String custnumber) async {
    try {
      var response = await http.post(Uri.parse(getbyuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"custnumber": custnumber}));
      return jsonDecode(utf8.decode(response.bodyBytes))['rest'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<List> allorder() async {
    try {
      var response = await http.post(Uri.parse(allorderlink),
          headers: {"Content-Type": "application/json"});
      return jsonDecode(utf8.decode(response.bodyBytes))['rest'] as List;
    } catch (e) {
      return [];
    }
  }

  // wallets
  static Future<bool> registerwallet(
      String number, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerwalletlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "notpay": "0",
            "paid": "0",
            "topup": "0",
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<Map> getwallet(String number) async {
    try {
      var response = await http.post(Uri.parse(getwalletlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number}));
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      return {};
    }
  }

  static Future<bool> updatewallet(String number, String notpay, String paid,
      String topup, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatewalletlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "notpay": notpay,
            "paid": paid,
            "topup": topup,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // wishlist
  static Future<bool> registerwishlist(
      String number, String billboardid, BuildContext context) async {
    try {
      displayprogress(context);
      var response = await http.post(Uri.parse(registerwishlistlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "billboardid": billboardid,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      await FirebaseHelper.sendnotificationto(sharedpref.readString('deviceid'),
          "Wish list", "New Billboard added to your wishlist");
      hideprogress(context);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<Map> wishlistbyuser(String number, String billboardid) async {
    try {
      var response = await http.post(Uri.parse(wishlistbyuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "billboardid": billboardid,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['rest'];
    } catch (e) {
      return {};
    }
  }

  static Future<List> wishlistbynumber(String number) async {
    try {
      var response = await http.post(Uri.parse(wishlistbynumberlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['rest'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> wishlistdelete(String id, BuildContext context) async {
    try {
      displayprogress(context);
      var response = await http.post(Uri.parse(wishlistdeletelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      await FirebaseHelper.sendnotificationto(sharedpref.readString('deviceid'),
          "Wish list deleted", "Billboard is deleted from your wishlist");
      hideprogress(context);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<Map> billboardbyid(String id) async {
    try {
      var response = await http.post(Uri.parse(billboardbyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['rest'];
    } catch (e) {
      return {};
    }
  }
}
