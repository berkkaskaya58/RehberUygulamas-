import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';

class SignUpController extends GetxController{
   
  Rx<Color> emailBorderColor = UIColors.borderColor.obs;
  //  Rx<Color> emailColor = UIColors.noErrorColor.obs;
  //     Rx<Color> passwordColor = UIColors.noErrorColor.obs;
  // Rx<Color> emailErrorColor = UIColors.errorColor.obs;
   Rx<Color> passwordBorderColor = UIColors.borderColor.obs;
  // Rx<Color> passwordErrorColor = UIColors.errorColor.obs;
   TextEditingController emailController = TextEditingController();
   TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
    FocusNode emailFocusNode = FocusNode();
FocusNode passwordFocusNode = FocusNode();
FocusNode password2FocusNode = FocusNode();
FocusNode nameFocusNode = FocusNode();
FocusNode numberFocusNode = FocusNode();

 

 

// Şifrelerin eşit olup olmadığını kontrol eden fonksiyon
  void isPasswordEqual() {
    if ((passwordController.text == passwordController2.text) ||
        (passwordController.text.isEmpty &&
        passwordController2.text.isEmpty)) {
      areSamePasswords.value = true;
    } else if (passwordController.text.length>8) {
       areSamePasswords.value = false;
    }
    else{
      areSamePasswords.value = false;
    }
  }
// Şifrelerin eşitlik kontrolüne göre border rengi
  Rx<Color> getPassword2BorderColor() {
    if (areSamePasswords.value) {
      return UIColors.noErrorBorderColor.obs;
    } else {
      return UIColors.errorBorderColor.obs;
    }
  }
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

 

  
}