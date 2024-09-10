import 'package:flutter/material.dart';
import 'package:telefon_rehberi/Widget/basicText.dart';
import 'package:telefon_rehberi/custom_divider.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ifYouDontHaveAccound.dart';
import 'package:telefon_rehberi/other_login_buttons.dart';
import 'package:telefon_rehberi/rememberMe_forgetPassword.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/page/bottom_navigation_bar.dart';
import 'package:telefon_rehberi/page/sign_page.dart';
import 'package:telefon_rehberi/ui/ui_image.dart';
import 'package:telefon_rehberi/Widget/widget_checkBox.dart';
import 'package:telefon_rehberi/Widget/widget_textFieldEMail.dart';
import 'package:telefon_rehberi/Widget/widget_textFieldPassword.dart';
import 'package:telefon_rehberi/Widget/widget_button.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: UIColors.white,
      body: const LoginPage(),
    ),
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  int passwordLength = 0; // Şifre uzunluğunu tutacak değişken

  Future<void> _login() async {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;

    // Yükleniyor diyalogunu göster
    showDialog(
      context: context,
      barrierDismissible: false, // Kullanıcının diyalogu kapatmasını engeller
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AlertDialog(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(color: UIColors.primary),
                  SizedBox(width: paddingHorizontal),
                  const Text('Giriş Yapılıyor...'),
                ],
              ),
            ),
          ],
        );
      },
    );

    // Simülasyon: Giriş işlemini bekle
    await Future.delayed(const Duration(seconds: 2));

    // Diyaloğu kapat
    Navigator.of(context).pop();

    // Burada giriş işlemi yapılır
    // Örneğin, başarılı giriş sonrası bir sayfaya yönlendirme yapılabilir
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CustomBottomNavigationBar(),
      ),
    );
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double paddingBottom = MediaQuery.of(context).size.height * 0.05;

    return Scaffold(
      backgroundColor: UIColors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: paddingHorizontal,
                right: paddingHorizontal,
                top: paddingTop,
                bottom: paddingBottom,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo'nun ortalanması
                  Image.asset(
                    ImagePath.logoIpsum,
                    fit: BoxFit
                        .contain, // Resmi konteyner içinde düzgün hizalamak için
                  ),
                  // Form elemanları
                  Column(
                    children: [
                      Row(
                        children: [
                          BasicText(
                            title: LocaleKeys.login,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          )
                        ],
                      ),
                      SizedBox(
                        height: paddingTop / 2,
                      ),
                      CustomTextFieldEMail(
                        controller: emailController,
                        hintText: LocaleKeys.hintTextMail,
                        obscureText: false,
                        focusNode: emailFocusNode,
                        nextFocusNode: passwordFocusNode,
                      ),
                      SizedBox(
                        height: paddingTop / 5,
                      ),
                      CustomTextFieldPassword(
                        controller: passwordController,
                        hintText: LocaleKeys.hintTextPassword,
                        obscureText: true,
                        focusNode: passwordFocusNode,
                        // Onpasswordfieldtap, you can set up the focus on the next field or submit
                      ),
                      SizedBox(
                        height: paddingTop / 5,
                      ),
                     const RemembermeForgetpassword(),
                      SizedBox(
                        height: paddingTop / 2,
                      ),
                      ButtonBasic(
                        text: LocaleKeys.login,
                        func: _login,
                      ),
                     const Customdivider(),
                      const OtherLoginButtons(),
                      SizedBox(
                        height: paddingTop / 5,
                      ),
                    ],
                  ),
                 const Ifyoudonthaveaccound(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
