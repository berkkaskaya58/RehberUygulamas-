import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddpeopleController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final List<TextEditingController> phoneNumberControllers = [
    TextEditingController()
  ];
  final List<FocusNode> phoneNumberFocusNodes = [FocusNode()]; // FocusNode listesi
   final FocusNode nameFocusNode = FocusNode();
  final FocusNode eMailFocusNode = FocusNode();
  
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
}
