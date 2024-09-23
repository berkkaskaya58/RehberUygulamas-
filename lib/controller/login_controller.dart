import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/view/view_home/bottom_navigation_bar.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final loginFormKey = GlobalKey<FormState>();
  final fireBaseAuth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  final globalKey = GlobalKey<ScaffoldState>();

  Color emailBorderColor = UIColors.borderColor;
  //  Rx<Color> emailColor = UIColors.noErrorColor.obs;
  //     Rx<Color> passwordColor = UIColors.noErrorColor.obs;
  // Rx<Color> emailErrorColor = UIColors.errorColor.obs;
  Color passwordBorderColor = UIColors.borderColor;
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

  Future<void> login() async {
    isLoading(true);
    try {
      // Giriş işlemleri
      await Future.delayed(const Duration(seconds: 2));
      // Yönlendirme işlemi
      Get.off(() => const CustomBottomNavigationBar()); // Yönlendirme stackten siler
    } catch (e) {
      // Hata yönetimi

      log(e.toString());
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

  void signInWithEmailAndPassword() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save(); // Form verilerini kaydet
      try {
        await fireBaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.off(() => const CustomBottomNavigationBar());
      } catch (e) {
        Get.snackbar("Hata", "Kayıtlı Kullanıcı Bulunamadı!! ");
        log(e.toString());
      }
    }
  }
}
