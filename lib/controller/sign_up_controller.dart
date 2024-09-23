import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/view/view_login/login_page.dart';

class SignUpController extends GetxController {
  final fireBaseAuth = FirebaseAuth.instance;
  final signFormKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  String email = '';
  String password = '';
  String password2 = '';
  String name = '';

  Color emailBorderColor = UIColors.borderColor;

  Color passwordBorderColor = UIColors.borderColor;

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
        (passwordController.text.isEmpty && passwordController2.text.isEmpty)) {
      areSamePasswords.value = true;
    } else if (passwordController.text.length > 8) {
      areSamePasswords.value = false;
    } else {
      areSamePasswords.value = false;
    }
  }

// Şifrelerin eşitlik kontrolüne göre border rengi
  Color getPassword2BorderColor() {
    if (password.isEmpty && password2.isEmpty) {
      return UIColors.borderColor;
    } else if (password == password2) {
      return UIColors.noErrorBorderColor;
    } else {
      return UIColors.errorBorderColor;
    }
  }

  Color getPassword2BackgroundColor(String password, String password2) {
    if (password.isEmpty && password2.isEmpty) {
      return UIColors.textFieldBackGround;
    } else if (password == password2) {
      return UIColors.noErrorColor;
    } else {
      return UIColors.errorColor;
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

  Color getPasswordBackgroundColor(String password) {
    if (password.isEmpty) {
      return UIColors.textFieldBackGround; // Boşken varsayılan border
    } else if (password.length <= 8) {
      return UIColors.noErrorColor; // Şifre 8 karakter ya da daha küçükse
    } else {
      return UIColors.errorColor; // Şifre uzunluğu 8'den büyükse
    }
  }

  Color getpasswordBorderColor(String password) {
    if (password.isEmpty) {
      return UIColors.borderColor; // Boşken varsayılan border
    } else if (password.length <= 8) {
      return UIColors.noErrorBorderColor; // Şifre 8 karakter ya da daha küçükse
    } else {
      return UIColors.errorBorderColor; // Şifre uzunluğu 8'den büyükse
    }
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

  void signInWithEmailAndPassword() async {
    if (signFormKey.currentState!.validate()) {
      signFormKey.currentState!.save(); // Form verilerini kaydet
      try {
        await fireBaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.off(() => const LoginPage());
      } catch (e) {
        Get.snackbar("Hata", "Kayıtlı Kullanıcı Bulunamadı!! ");
        log(e.toString());
      }
    }
  }
}
