import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:telefon_rehberi/controller/login_controller.dart';
import 'package:telefon_rehberi/widget/basicText.dart';
import 'package:telefon_rehberi/widget/widget_checkBox.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';

class RemembermeForgetpassword extends StatelessWidget {
  final Function? func;
  const RemembermeForgetpassword({super.key,this.func});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    final fireBaseAuth = FirebaseAuth.instance;

    // Şifre sıfırlama fonksiyonu
    Future<void> resetPassword() async {
      try {
        // Email controller'dan email adresini alıyoruz
        String email = loginController.emailController.text.trim();
        if (email.isNotEmpty) {
          await fireBaseAuth.sendPasswordResetEmail(email: email);
          // Başarılı olduğunda kullanıcıya bildirim verilebilir
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Şifre sıfırlama e-postası gönderildi.')),
          );
        } else {
          // E-posta boşsa kullanıcıya uyarı göster
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lütfen geçerli bir e-posta adresi girin.')),
            
          );
          print(email.trim);
        }
      } catch (e) {
        // Hata durumunda kullanıcıya mesaj gösterebilirsiniz
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Şifre sıfırlama işlemi başarısız oldu.')),
        );
      }
    }

    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomCheckBox(),
            SizedBox(
              width: paddingHorizontal / 3,
            ),
            BasicText(
              title: LocaleKeys.rememberMe,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Şifre sıfırlama fonksiyonunu tetikliyoruz
           resetPassword();
          },
          child: BasicText(
            title: LocaleKeys.forgetPassword,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
