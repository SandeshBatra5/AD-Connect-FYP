// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

import '../../../app/app.locator.dart';
import '../../../services/fire_service.dart';

class FirebaseHelper {
  static Future<String> uploadFile(File? file, String phone) async {
    final fireService = locator<FireService>();

    String filename = path.basename(file!.path);
    String extension = path.extension(file.path);
    String randomChars = DateTime.now().millisecondsSinceEpoch.toString();
    String uniqueFilename = '$filename-$randomChars$extension';

    UploadTask uploadTask = fireService.storage
        .child('user')
        .child(phone)
        .child(uniqueFilename)
        .putFile(file);
    await uploadTask;
    String downloadURL = await fireService.storage
        .child('user')
        .child(phone)
        .child(uniqueFilename)
        .getDownloadURL();
    return downloadURL;
  }

  static Future<void> sendnotificationto(
      String notificationid, String title, String body) async {
    String keys =
        'AAAASdey53Y:APA91bEUTfy48KL13dzNgekFOdx5TbIm8sJNO7sbFJhWa54DZlltECyr6eJSavyWgZdWAxsxCsfayzcOzKjf2h3wAAF-zvm3tuV2fkVecI14qCekxzZig-11La02lxT-G4hFxG5sKHP6';
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode({
          'to': notificationid,
          'priority': 'high',
          'notification': {'title': title, 'body': body}
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$keys'
        });
  }
}
