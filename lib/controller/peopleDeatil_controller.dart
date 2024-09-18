import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class PeopledeatilController extends GetxController {
  final List<TextEditingController> phoneNumberControllers = [
    TextEditingController()
  ];
  File? imagePath;
final RxList<XFile> images = <XFile>[].obs; // Resimler için bir liste ekleyin

  void _addPhoneNumberField() {
    phoneNumberControllers.add(TextEditingController());
  }

   Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery); // Camera yerine gallery seçin
    if (pickedImage != null) {
      images.add(pickedImage); // Seçilen resmi listeye ekleyin
    }
  }

  Future<void> message() async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: '+904445553525', // Boşluk olmadan
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print("Could not launch $launchUri");
      Get.snackbar("Hata", "Sms uygulaması açılamadı.");
    }
  }

 Future<void> eMail() async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: 'example@example.com', // E-posta adresini doğru yazın
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    // Hata durumunda mesaj göster
    print("Could not launch $launchUri");
    // Kullanıcıya bir hata mesajı gösterebilirsiniz
    Get.snackbar("Hata", "E-Mail uygulaması açılamadı.");
  }
}


  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path:
          '+1234567890', // Numaranızı uluslararası formatta ve boşluksuz yazın.
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // Hata durumunda mesaj göster
      print("Could not launch $launchUri");
      // Kullanıcıya bir hata mesajı gösterebilirsiniz
      Get.snackbar("Hata", "Telefon uygulaması açılamadı.");
    }
  }
}
