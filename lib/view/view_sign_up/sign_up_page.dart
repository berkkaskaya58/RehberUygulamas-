// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:telefon_rehberi/textField_error_controller.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';
import 'package:telefon_rehberi/widget/basicText.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/view/view_login/login_page.dart';
import 'package:telefon_rehberi/ui/ui_image.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';
import 'package:telefon_rehberi/widget/widget_basic_text_field.dart';

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
final textFieldErrorController=Get.find<TextfieldErrorController>();

    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double paddingBottom = MediaQuery.of(context).size.height * 0.05;
    
    return Obx(()=>
       Scaffold(
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
      
                  CustomTextField(
                    controller: nameController,
                    hintText: LocaleKeys.hintTextNameSurname,
                    obscureText: false,
                    focusNode: nameFocusNode,
                    nextFocusNode: eMailFocusNode,
                  ),
                  SizedBox(height: paddingTop / 4),
                  CustomTextField(
                           controller: textFieldErrorController.emailController,
                            onChanged: (p0) {
                              textFieldErrorController
                                  .isEmail(textFieldErrorController.emailController.text);
                              textFieldErrorController.emailBorderColor =
                                  textFieldErrorController.getEmailBorderColor(
                                      textFieldErrorController.emailController.text);
                            
                            }, // Fonksiyonu onChanged'de kullan
                            borderSideColors: textFieldErrorController.emailBorderColor.value,
                            hintText: LocaleKeys.hintTextMail,
                            obscureText: false,
                            
                            
                          ),
      
                          textFieldErrorController.isValidEmail.value
                              ? Container()
                              : Align(
                                  alignment: Alignment.centerLeft,
                                  child: BasicText(
                                    titleColor: UIColors.errorMessageColor,
                                    title: UIText.errorMessage,
                                    fontSize: 12,
                                  )),
                  SizedBox(height: paddingTop / 4),
                    CustomTextField(
                            controller: textFieldErrorController.passwordController2,
                            onChanged: (p0) {
                              textFieldErrorController.isPassword(textFieldErrorController
                                  .passwordController.text);
                              textFieldErrorController.passwordBorderColor =
                                  textFieldErrorController.getpasswordBorderColor(
                                      textFieldErrorController.passwordController.text);
                              // textFieldErrorController.errorColor =
                              //     textFieldErrorController.getPasswordColor(
                              //         textFieldErrorController.emailController.text);
                            }, // GetX ile yönetiliyor
                             borderSideColors: textFieldErrorController.passwordBorderColor.value,
                            hintText: LocaleKeys.hintTextPassword,
                            obscureText: true,
      
                            //errorMessage: loginController.passwordErrorMessage(),
                          ),
                          textFieldErrorController.isCorrectPassword.value
                              ? Align(
                                
                                  alignment: Alignment.centerLeft,
                                  child: BasicText(
                                    titleColor: UIColors.errorMessageColor,
                                    title: UIText.errorMessage,
                                    fontSize: 12,
                                  ))
                              : Container(),
                  SizedBox(height: paddingTop / 4),
                  CustomTextField(
                            controller: textFieldErrorController.passwordController2,
                            onChanged: (p0) {
                              textFieldErrorController.isPassword(textFieldErrorController
                                  .passwordController.text);
                              textFieldErrorController.passwordBorderColor =
                                  textFieldErrorController.getpasswordBorderColor(
                                      textFieldErrorController.passwordController.text);
                              // textFieldErrorController.errorColor =
                              //     textFieldErrorController.getPasswordColor(
                              //         textFieldErrorController.emailController.text);
                            }, // GetX ile yönetiliyor
                             borderSideColors: textFieldErrorController.passwordBorderColor.value,
                            hintText: LocaleKeys.hintTextPassword,
                            obscureText: true,
      
                            //errorMessage: loginController.passwordErrorMessage(),
                          ),
                          textFieldErrorController.isCorrectPassword.value
                              ? Align(
                                
                                  alignment: Alignment.centerLeft,
                                  child: BasicText(
                                    titleColor: UIColors.errorMessageColor,
                                    title: UIText.errorMessage,
                                    fontSize: 12,
                                  ))
                              : Container(),
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
      ),
    );
  }
}
