import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';

class EditPeopleController extends GetxController {
   late List<DocumentSnapshot<Object?>> list;
  late int index;
EditPeopleController({required this.list,required this.index});
  
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
    Color emailBorderColor = UIColors.borderColor;
  Color emailErrorColor = UIColors.errorColor;

 
 
  // @override
  // void onInit() {
  //   super.onInit();                                               // initialize e bak Çalış !!!!!!!!!!!!!!!!!!!!!
  //   init();
  // }

  // Future<void> init() async {
  //   var data = list[index].data() as Map<String, dynamic>;

  //    nameController.text = data['name'];
  //   numberController.text = data['number'];
  //   emailController.text = data['email'];
  // }
 
 // EditPerson widget'ında
  @override
  void onInit() {
    super.onInit();
    final data = list[index].data() as Map<String, dynamic>;
    setInitialValues(data );
    // Burada veri alımını yapabilirsiniz
  }

  @override
  void onClose() {
    // Kaynakları serbest bırak
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void setInitialValues(Map<String, dynamic> data) {
    if (nameController.text.isEmpty &&
        numberController.text.isEmpty &&
        emailController.text.isEmpty) {
      nameController.text = data['name'] ?? ''; // Null kontrol
      numberController.text = data['number'] ?? ''; // Null kontrol
      emailController.text = data['email'] ?? ''; // Null kontrol
    }
}

  // Şifre ve e-posta doğrulaması
  RxBool isValidEmail = true.obs;
  RxBool isCorrectPassword = false.obs;
  
  final RxList<XFile> images = <XFile>[].obs;

  get name => null; // Resimler için bir liste ekleyin

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

  // @override
  // void onClose() {
  //   // Dispose işlemlerini burada yapın
  //   nameController.dispose();
  //   emailController.dispose();
  //   for (var controller in phoneNumberControllers) {
  //     controller.dispose();
  //   }
  //   super.onClose();
  // }
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
//  

//  Future<void> updatePerson(List<DocumentSnapshot<Object?>> list, int index) async {
//     var data = list[index].data() as Map<String, dynamic>;
//     String docId = data['id']; // Firestore'daki belge kimliği

//     await FirebaseFirestore.instance.collection('people').doc(docId).update({
//       'name': nameController.text,
//       'number': numberController.text,
//       'email': emailController.text,
//     });
//   }
  }
  


