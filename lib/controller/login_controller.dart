import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/view/view_home/bottom_navigation_bar.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
    

  
  Rx<Color> emailBorderColor = UIColors.borderColor.obs;
  //  Rx<Color> emailColor = UIColors.noErrorColor.obs;
  //     Rx<Color> passwordColor = UIColors.noErrorColor.obs;
  // Rx<Color> emailErrorColor = UIColors.errorColor.obs;
   Rx<Color> passwordBorderColor = UIColors.borderColor.obs;
  // Rx<Color> passwordErrorColor = UIColors.errorColor.obs;
   TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    FocusNode emailFocusNode = FocusNode();
FocusNode passwordFocusNode = FocusNode();
FocusNode password2FocusNode = FocusNode();
FocusNode nameFocusNode = FocusNode();
FocusNode numberFocusNode = FocusNode();

 

 


  // Şifre ve e-posta doğrulaması
  RxBool isValidEmail = true.obs;
  RxBool isCorrectPassword = false.obs;
  RxBool areSamePasswords = true.obs;

 void isPassword(String password) {
    if (password.isEmpty) {
      isCorrectPassword.value = false;
    } else if (password.length <= 8) {
      isCorrectPassword.value = false;
    } else {
      isCorrectPassword.value = true;
    }
  }

  
 
  Rx<Color> getPasswordColor(String password) {
    if (password.isEmpty) {
      return UIColors.borderColor.obs; // Boşken varsayılan arka plan
    } else if (password.length<=8) {
      return UIColors.noErrorBorderColor.obs; // Şifre 8 karakter ya da daha küçükse
    } else {
      return UIColors.errorBorderColor.obs; // Şifre uzunluğu 8'den büyükse
    }
  }

   Rx<Color>  getpasswordBorderColor(String password) {
    if ( password.isEmpty) {
      return UIColors.borderColor.obs; // Boşken varsayılan border
    } else if ( password.length<=8) {
      return UIColors.noErrorBorderColor.obs; // Şifre 8 karakter ya da daha küçükse
    } else {
      return UIColors.errorBorderColor.obs; // Şifre uzunluğu 8'den büyükse
    }


}
 
 void isEmail(String email) {
   if (email.isEmpty) {
      isValidEmail.value = true;
    }
    else if (email.contains('@') && email.endsWith('.com')) {
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

 

  Future<void> login() async {
    isLoading(true);
    try {
      // Giriş işlemleri
      await Future.delayed(Duration(seconds: 2));
      // Yönlendirme işlemi
      Get.off(() => CustomBottomNavigationBar()); // Yönlendirme stackten siler
    } catch (e) {
      // Hata yönetimi
       
      print(e.toString());
    } finally {
      isLoading(false);
     
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }





 
 
}
