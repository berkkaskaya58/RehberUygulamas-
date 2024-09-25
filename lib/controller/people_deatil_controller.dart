import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  late List<DocumentSnapshot<Object?>> list;
  late int index;
   late Map<String, dynamic> data; // data değişkenini burada tanımlıyoruz
  @override
  PeopledeatilController({
    required this.list,
    required this.index,
  });

  @override
  void onInit() {
    super.onInit();
     data =
        list[index].data() as Map<String, dynamic>; // onInit içinde veriyi al
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery); // Camera yerine gallery seçin
    if (pickedImage != null) {
      images.add(pickedImage); // Seçilen resmi listeye ekleyin
    }
  }

  Future<void> message() async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: data['number']??'', 
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      log("Could not launch $launchUri");
      Get.snackbar("Hata", "Sms uygulaması açılamadı.");
    }
  }

  Future<void> eMail() async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: data['email'], // E-posta adresini doğru yazın
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // Hata durumunda mesaj göster
      log("Could not launch $launchUri");
      // Kullanıcıya bir hata mesajı gösterebilirsiniz
      log("E-Mail uygulaması açılamadı.");
    }
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path:
          data['number'], // Numaranızı uluslararası formatta ve boşluksuz yazın.
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // Hata durumunda mesaj göster
      log("Could not launch $launchUri");
      // Kullanıcıya bir hata mesajı gösterebilirsiniz
      Get.snackbar("Hata", "Telefon uygulaması açılamadı.");
    }
  }
}
