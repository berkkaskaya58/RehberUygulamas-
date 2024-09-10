// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:telefon_rehberi/Widget/basicText.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/page/login_page.dart';
import 'package:telefon_rehberi/ui/ui_image.dart';
import 'package:telefon_rehberi/Widget/widget_button.dart';
import 'package:telefon_rehberi/Widget/widget_textFieldEMail.dart';
import 'package:telefon_rehberi/Widget/widget_textFieldName.dart';
import 'package:telefon_rehberi/Widget/widget_textFieldPassword.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignPage(),
  ));
}

class SignPage extends StatelessWidget {
  SignPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final passwordCOntroller2 = TextEditingController();
  int passwordLength = 0;
final FocusNode nameFocusNode=FocusNode();
final FocusNode eMailFocusNode=FocusNode();
final FocusNode passwordFocusNode=FocusNode();
final FocusNode passwordFocusNode2=FocusNode();

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double paddingBottom = MediaQuery.of(context).size.height * 0.05;
    return Scaffold(
      backgroundColor: UIColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: paddingTop / 2,
                left: paddingHorizontal,
                right: paddingHorizontal,
                bottom: paddingBottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Logo'nun ortalanması
                Image.asset(
                  ImagePath.logoIpsum,
                  fit: BoxFit
                      .contain, // Resmi konteyner içinde düzgün hizalamak için
                ),
                // Form elemanları
                Padding(
                  padding: EdgeInsets.only(
                      top: paddingTop * 2, bottom: paddingBottom / 2),
                  child: Row(
                    children: [
                     BasicText(title:  LocaleKeys.signUp,fontWeight: FontWeight.w600,fontSize: 24,)
                    ],
                  ),
                ),

                CustomTextFieldName(
                  controller: nameController,
                  hintText: LocaleKeys.hintTextNameSurname,
                  obscureText: false,
                  focusNode: nameFocusNode,
                  nextFocusNode: eMailFocusNode,
                ),
                SizedBox(height: paddingTop / 4),
                CustomTextFieldEMail(
                  controller: emailController,
                  hintText: LocaleKeys.hintTextMail,
                  obscureText: false,
                  focusNode: eMailFocusNode,
                  nextFocusNode: passwordFocusNode,
                ),
                SizedBox(height: paddingTop / 4),
                CustomTextFieldPassword(
                  controller: passwordController,
                  hintText: LocaleKeys.hintTextPassword,
                  obscureText: true,
                  focusNode: passwordFocusNode,
                  nextFocusNode: passwordFocusNode2,

                ),
                SizedBox(height: paddingTop / 4),
                CustomTextFieldPassword(
                  controller: passwordCOntroller2,
                  hintText: LocaleKeys.hintTextThePasswordAgain,
                  obscureText: true,
                  focusNode: passwordFocusNode2,
                ),
                SizedBox(height: paddingTop / 1.5),

                ButtonBasic(
                  func: () {},
                  text: LocaleKeys.signUp,
                ),
                SizedBox(height: paddingTop / 1.5),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    SizedBox(width: paddingHorizontal ),
                    const Text(LocaleKeys.or),
                     SizedBox(width: paddingHorizontal),
                    const Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: paddingTop / 1.5),
                Column(
                  children: [
                    ButtonBasic(
                              prefixPath: ImagePath.google,
                              textColor: Colors.black,
                              color: UIColors.white,
                              text: LocaleKeys.loginWithGoogle,
                               titleColor: UIColors.black,
                               fontSize: 14,
                               fontWeight:FontWeight.w500,
                              func: () {},
                            ),
                    SizedBox(height: paddingTop / 4),
                     ButtonBasic(
                              prefixPath: ImagePath.facebook,
                              textColor: Colors.black,
                              color: UIColors.white,
                              
                              text: LocaleKeys.loginWithFacebook,
                              titleColor: UIColors.black,
                                fontSize: 14,
                               fontWeight:FontWeight.w500,
                              func: () {},
                            ),
                  ],
                ),
                SizedBox(height: paddingTop),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BasicText(title: LocaleKeys.ifYouDoHaveAccound,fontSize: 14,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                       child: BasicText(title:  LocaleKeys.log_in,fontSize: 14,fontWeight: FontWeight.w600,)
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
