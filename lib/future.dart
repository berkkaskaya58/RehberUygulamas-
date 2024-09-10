import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class FutureVoid {
  static Future<File?> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }





}
