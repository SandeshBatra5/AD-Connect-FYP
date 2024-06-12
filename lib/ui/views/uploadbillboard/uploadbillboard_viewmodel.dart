// ignore_for_file: use_build_context_synchronously, list_remove_unrelated_type

import 'dart:io';

import 'package:billboard/ui/common/apihelpers/apihelper.dart';
import 'package:billboard/ui/common/apihelpers/firebsaeuploadhelper.dart';
import 'package:billboard/ui/common/uihelper/snakbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/sharedpref_service.dart';

class UploadbillboardViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefService>();

  TextEditingController price = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController lon = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController date = TextEditingController();

  List<XFile> selectedImages = [];
  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(
      imageQuality: 5,
    );
    selectedImages = pickedImages;
    notifyListeners();
  }

  void delete(XFile file) {
    selectedImages.remove(file);
    notifyListeners();
  }

  void deletealready(String e) {
    selectedImages.remove(e);
    notifyListeners();
  }

  Future<void> location() async {
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
    Position p = await Geolocator.getCurrentPosition();
    lat.text = p.latitude.toString();
    lon.text = p.longitude.toString();
    notifyListeners();
  }

  Future<void> save(BuildContext context) async {
    if (price.text.isEmpty ||
        width.text.isEmpty ||
        height.text.isEmpty ||
        lat.text.isEmpty ||
        lon.text.isEmpty ||
        des.text.isEmpty ||
        date.text.isEmpty) {
      show_snackbar(context, "Enter all fields");
    } else if (selectedImages.isEmpty) {
      show_snackbar(context, "Add Images");
    } else {
      displayprogress(context);
      List<String> fimage = [];
      for (var element in selectedImages) {
        fimage.add(await FirebaseHelper.uploadFile(
            File(element.path), _sharedpref.readString('number')));
      }
      bool check = await ApiHelper.registerbillboard(
          _sharedpref.readString('number'),
          price.text,
          width.text,
          height.text,
          lon.text,
          lat.text,
          des.text,
          date.text,
          fimage,
          context);
      if (check) {
        hideprogress(context);
        show_snackbar(context, "Registered");
        _navigationService.back();
      } else {
        hideprogress(context);
        show_snackbar(context, "Try again later");
      }
    }
  }

  Future<void> update(BuildContext context, String id) async {
    if (price.text.isEmpty ||
        width.text.isEmpty ||
        height.text.isEmpty ||
        lat.text.isEmpty ||
        lon.text.isEmpty ||
        des.text.isEmpty ||
        date.text.isEmpty) {
      show_snackbar(context, "Enter all fields");
    } else if (selectedImages.isEmpty && alreadyimg.isEmpty) {
      show_snackbar(context, "Add Images");
    } else {
      displayprogress(context);
      List<String> finalimages = [];
      for (var i in alreadyimg) {
        finalimages.add(i);
      }
      for (var element in selectedImages) {
        finalimages.add(await FirebaseHelper.uploadFile(
            File(element.path), _sharedpref.readString("number")));
      }
      bool check = await ApiHelper.updatebillboard(
          id,
          price.text,
          width.text,
          height.text,
          lon.text,
          lat.text,
          des.text,
          date.text,
          finalimages,
          context);
      if (check) {
        hideprogress(context);
        show_snackbar(context, "Updated");
        _navigationService.back();
      } else {
        hideprogress(context);
        show_snackbar(context, "Try again later");
      }
    }
  }

  List alreadyimg = [];
  void firstrun(Map data) {
    if (data.isNotEmpty) {
      price.text = data['price'];
      width.text = data['width'];
      height.text = data['height'];
      lon.text = data['lon'];
      lat.text = data['lat'];
      des.text = data['des'];
      date.text = data['avaliable'];
      alreadyimg = data['image'];
    }
  }

  Future<void> selectdate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      date.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      notifyListeners();
    }
  }
}
