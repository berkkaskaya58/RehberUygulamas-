import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/controller/sign_up_controller.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';
import 'package:telefon_rehberi/widget/basicText.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_image.dart';
import 'package:telefon_rehberi/widget/ifYouHaveAccound.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/custom_divider.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/other_login_buttons.dart';
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

 
  final formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    final fireBaseAuth = FirebaseAuth.instance;
    String email = '';
    String password = '';
    String password2 = '';
    String name = '';
    final signUpController = Get.put(SignUpController());

    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double paddingBottom = MediaQuery.of(context).size.height * 0.05;

    return Obx(
      () => Scaffold(
        backgroundColor: UIColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: MediaQuery.of(context).viewInsets.bottom > 0
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: paddingTop / 2,
                left: paddingHorizontal,
                right: paddingHorizontal,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      ImagePath.logoIpsum,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: paddingTop * 2, bottom: paddingBottom / 2),
                      child: Row(
                        children: [
                          BasicText(
                            title: LocaleKeys.signUp,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          )
                        ],
                      ),
                    ),
                    CustomTextField(
                      onSaved: (value) {
                        name = value ?? '';
                      },
                      showIcon: false,
                      controller: signUpController.nameController,
                      hintText: LocaleKeys.hintTextNameSurname,
                      obscureText: false,
                      focusNode: signUpController.nameFocusNode,
                      nextFocusNode: signUpController.emailFocusNode,
                    ),
                    SizedBox(height: paddingTop / 4),
                    CustomTextField(
                      onSaved: (value) {
                        email = value ?? '';
                      },
                      focusNode: signUpController.emailFocusNode,
                      nextFocusNode: signUpController.passwordFocusNode,
                      showIcon: false,
                      controller: signUpController.emailController,
                      onChanged: (p0) {
                        signUpController.isEmail(signUpController.emailController.text);
                        signUpController.emailBorderColor =
                            signUpController
                                .getEmailBorderColor(signUpController.emailController.text);
                      },
                      borderSideColors:
                          signUpController.emailBorderColor.value,
                      hintText: LocaleKeys.hintTextMail,
                      obscureText: false,
                      backgroundColor:
                          signUpController.isValidEmail.value
                              ? UIColors.noErrorColor
                              : UIColors.errorColor,
                    ),
                    signUpController.isValidEmail.value
                        ? Container()
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: BasicText(
                              titleColor: UIColors.errorMessageColor,
                              title: UIText.errorMessageEmail,
                              fontSize: 12,
                            )),
                    SizedBox(height: paddingTop / 4),
                    CustomTextField(
                      onSaved: (value) {
                        password = value ?? '';
                      },
                      focusNode: signUpController.passwordFocusNode,
                      nextFocusNode: signUpController.password2FocusNode,
                      showIcon: true,
                      controller: signUpController.passwordController,
                      onChanged: (p0) {
                        signUpController
                            .isPassword(signUpController.passwordController.text);
                        signUpController.isPasswordEqual();
                      },
                      borderSideColors: signUpController
                                  .isCorrectPassword.value ||
                              signUpController.areSamePasswords == false
                          ? UIColors.errorBorderColor
                          : UIColors.borderColor,
                      hintText: LocaleKeys.hintTextPassword,
                      obscureText: true,
                      backgroundColor: signUpController
                                  .isCorrectPassword.value ||
                              signUpController.areSamePasswords == false
                          ? UIColors.errorColor
                          : UIColors.noErrorColor,
                    ),
                    signUpController.isCorrectPassword.value
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: BasicText(
                              titleColor: UIColors.errorMessageColor,
                              title: UIText.errorMessagePassword,
                              fontSize: 12,
                            ),
                          )
                        : Container(),
                    SizedBox(height: paddingTop / 4),
                    CustomTextField(
                      onSaved: (value) {
                        password2 = value ?? '';
                      },
                      focusNode: signUpController.password2FocusNode,
                      showIcon: true,
                      controller: signUpController.passwordController2,
                      onChanged: (p0) {
                        signUpController.isPasswordEqual();
                      },
                      borderSideColors: signUpController
                                  .isCorrectPassword.value ||
                              signUpController.areSamePasswords == false
                          ? UIColors.errorBorderColor
                          : UIColors.borderColor,
                      hintText: UIText.hintTextThePasswordAgain,
                      obscureText: true,
                      backgroundColor: signUpController
                                  .isCorrectPassword.value ||
                              signUpController.areSamePasswords == false
                          ? UIColors.errorColor
                          : UIColors.noErrorColor,
                    ),
                    signUpController.areSamePasswords.value
                        ? Container()
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: BasicText(
                              titleColor: UIColors.errorMessageColor,
                              title: UIText.notSamePassword,
                              fontSize: 12,
                            ),
                          ),
                    SizedBox(height: paddingTop * 1.5),
                    ButtonBasic(
                      func: () async {
                        formKey.currentState!.save(); // Form verilerini kaydet

                        // Firebase Authentication işlemini gerçekleştirme
                        try {
                          var userResult =
                              await fireBaseAuth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          // Başarı durumunda kullanıcıyı Firestore'a kaydetmek için ek işlem yapabilirsiniz
                          // Örneğin: Firestore'a kullanıcı adını ekleme
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      text: LocaleKeys.signUp,
                    ),
                    const Customdivider(),
                     OtherLoginButtons(),
                    SizedBox(height: paddingTop * 1.5),
                    const IfYouHaveAccound()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
