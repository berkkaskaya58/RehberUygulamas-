import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';

class TextfieldErrorController extends GetxController{


  
  Rx<Color> emailBorderColor = UIColors.borderColor.obs;
  Rx<Color> emailErrorColor = UIColors.errorColor.obs;
   Rx<Color> passwordBorderColor = UIColors.borderColor.obs;
  Rx<Color> passwordErrorColor = UIColors.errorColor.obs;
   TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    TextEditingController passwordController2 = TextEditingController();

 

 


  // Şifre ve e-posta doğrulaması
  RxBool isValidEmail = true.obs;
  RxBool isCorrectPassword = false.obs;

 void isPassword(String text) {
    if (text.isEmpty) {
      isCorrectPassword.value = false;
    } else if (text.length <= 8) {
      isCorrectPassword.value = false;
    } else {
      isCorrectPassword.value = true;
    }
  }

 
  Rx<Color> getPasswordColor(String password) {
    if (password.isEmpty) {
      return UIColors.textFieldBackGround.obs; // Boşken varsayılan arka plan
    } else if (password.length<=8) {
      return UIColors.noErrorColor.obs; // Şifre 8 karakter ya da daha küçükse
    } else {
      return UIColors.errorColor.obs; // Şifre uzunluğu 8'den büyükse
    }
  }

   Rx<Color>  getpasswordBorderColor(String password) {
    if ( password.isEmpty) {
      return UIColors.textFieldBackGround.obs; // Boşken varsayılan border
    } else if ( password.length<=8) {
      return UIColors.noErrorBorderColor.obs; // Şifre 8 karakter ya da daha küçükse
    } else {
      return UIColors.errorBorderColor.obs; // Şifre uzunluğu 8'den büyükse
    }


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
      return UIColors.textFieldBackGround.obs; // Boşsa varsayılan border
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