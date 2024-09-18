import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';

class EditPeopleController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
   final numberController = TextEditingController();
  
  final List<TextEditingController> phoneNumberControllers = [
    TextEditingController()
  ];
  final List<FocusNode> phoneNumberFocusNodes = [FocusNode()]; // FocusNode listesi
   final FocusNode nameFocusNode = FocusNode();
      final FocusNode numberFocusNode = FocusNode();

  final FocusNode eMailFocusNode = FocusNode();
    Rx<Color> emailBorderColor = UIColors.borderColor.obs;
  Rx<Color> emailErrorColor = UIColors.errorColor.obs;

 

 


  // Şifre ve e-posta doğrulaması
  RxBool isValidEmail = true.obs;
  RxBool isCorrectPassword = false.obs;
  
  final RxList<XFile> images = <XFile>[].obs; // Resimler için bir liste ekleyin

  void setEmail(String value) {
    emailController.text = value;
  }

  void setName(String value) {
    nameController.text = value;
  }

  void addPhoneNumber() {
   // Direkt olarak kendi içindeki phoneNumberControllers'a ekleme yapın
    phoneNumberControllers.add(TextEditingController());
     phoneNumberFocusNodes.add(FocusNode());
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery); // Camera yerine gallery seçin
    if (pickedImage != null) {
      images.add(pickedImage); // Seçilen resmi listeye ekleyin
    }
  }

  @override
  void onClose() {
    // Dispose işlemlerini burada yapın
    nameController.dispose();
    emailController.dispose();
    for (var controller in phoneNumberControllers) {
      controller.dispose();
    }
    super.onClose();
  }
  void isEmail(String text) {
   if (text.isEmpty) {
      isValidEmail.value = true;
    }
    else if (text.contains('@') && text.endsWith('.com')) {
      isValidEmail.value = true;
    }   else {
      isValidEmail.value = false;
    }
  }

  // E-posta renk kontrolü
 Rx<Color> getEmailBorderColor(String email) {
    if (email.isEmpty) {
      return UIColors.borderColor.obs; // Boşsa varsayılan border
    } else if (isValidEmail.value) {
      return UIColors.noErrorBorderColor.obs;  
    } else {
      return UIColors.errorBorderColor.obs; 
    }
  }

  Rx<Color> getEmailColor(String email) {
    if (email.isEmpty) {
      return UIColors.textFieldBackGround.obs; // Boşsa varsayılan border
    } else if (isValidEmail.value) {
      return UIColors.noErrorColor.obs;  
    } else {
      return UIColors.errorColor.obs; 
    }
  }
  

}
