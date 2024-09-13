import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/view/view_home/bottom_navigation_bar.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
     TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

 

  Future<void> login() async {
    isLoading(true);
    try {
      // Giriş işlemleri
      await Future.delayed(Duration(seconds: 2));
      // Yönlendirme işlemi
      Get.off(() => CustomBottomNavigationBar()); // Yönlendirme stackten siler
    } catch (e) {
      // Hata yönetimi
      print('Giriş hatası: $e');
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
