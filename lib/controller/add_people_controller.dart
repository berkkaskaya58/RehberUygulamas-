import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/view/view_home/bottom_navigation_bar.dart';

class AddPeopleController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();                                               // initialize e bak Çalış !!!!!!!!!!!!!!!!!!!!!
  //   init();
  // }

  // Future<void> init() async {
  //   print("init tetiklendi");
  // }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();

  final List<TextEditingController> phoneNumberControllers = [
    TextEditingController()
  ];
  final List<FocusNode> phoneNumberFocusNodes = [FocusNode()];
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode numberFocusNode = FocusNode();
  Rx<Color> emailBorderColor = UIColors.borderColor.obs;
  RxBool isValidEmail = true.obs;

  // Seçilen resmin URL'sini saklamak için bir değişken
  RxString uploadFile = ''.obs;

  void addPhoneNumber() {
    phoneNumberControllers.add(TextEditingController());
    phoneNumberFocusNodes.add(FocusNode());
  }

  Future<void> selectImage() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    // Resim seçici ile görüntü seç
    var selectImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selectImage != null) {
      File uploadFileTemp = File(selectImage.path);

      // Benzersiz dosya adı oluştur
      String fileName =
          'ProfilResmi_${DateTime.now().millisecondsSinceEpoch}.png';

      Reference reference = FirebaseStorage.instance
          .ref()
          .child('Profil Resimleri')
          .child(auth.currentUser!.uid)
          .child(fileName);

      UploadTask uploadTask = reference.putFile(uploadFileTemp);

      try {
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        String url = await snapshot.ref.getDownloadURL();
        uploadFile.value = url; // Yüklenen resmin URL'sini sakla
        log("Resim başarıyla yüklendi: $url");

        // URL'yi veri tabanına kaydet
        await saveImageUrlToDatabase(url);
      } catch (e) {
        log("Resim yükleme hatası: $e");
        Get.snackbar("Hata", "Resim yüklenemedi.");
      }
    } else {
      log("Resim seçilmedi.");
    }
  }

// Resim URL'sini veri tabanına kaydet
  Future<void> saveImageUrlToDatabase(String url) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'profileImageUrl': url,
    }, SetOptions(merge: true));
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    for (var controller in phoneNumberControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void isEmail(String email) {
    if (email.isEmpty) {
      isValidEmail.value = true;
    } else if (email.contains('@') && email.endsWith('.com')) {
      isValidEmail.value = true;
    } else {
      isValidEmail.value = false;
    }
  }

  // E-posta renk kontrolü
  Color getEmailBorderColor(String email) {
    if (email.isEmpty) {
      return UIColors.borderColor; // Boşsa varsayılan border
    } else if (isValidEmail.value) {
      return UIColors.noErrorBorderColor;
    } else {
      return UIColors.errorBorderColor;
    }
  }

  Color getEmailBackgroundColor(String email) {
    if (email.isEmpty) {
      return UIColors.textFieldBackGround; // Boşsa varsayılan border
    } else if (isValidEmail.value) {
      return UIColors.noErrorColor;
    } else {
      return UIColors.errorColor;
    }
  }

  void addPeople() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    CollectionReference firebaseCollectionRef =
        fireStore.collection('FirebaseCollection');

    Map<String, dynamic> contactData = {
      'name': nameController.text,
      'number': numberController.text,
      if (isValidEmail.value) 'email': emailController.text,
    };

    try {
      if (isValidEmail.value) {
        await firebaseCollectionRef.doc(nameController.text).set(contactData);
        Get.snackbar('Başarılı', 'Kişi başarıyla eklendi');
        Get.off(const CustomBottomNavigationBar());
        nameController.text = "";
        numberController.text = "";
        emailController.text = "";
      } else {
        Get.snackbar('Hata', 'Hatalı Email girdiniz');
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Hata', ' ${e.toString()}');
    }
  }
}
