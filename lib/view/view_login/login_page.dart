import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';
import 'package:telefon_rehberi/widget/basicText.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';
import 'package:telefon_rehberi/widget/widget_basic_text_field.dart';
import 'package:telefon_rehberi/controller/login_controller.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_image.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/custom_divider.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/if_you_dont_have_accound.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/other_login_buttons.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/remember_me_forget_password.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginController = Get.put(LoginController()); // Controller'ı GetX ile bağla

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    String email = '';
    String password = '';
    final formKey = GlobalKey<FormState>();
    final fireBaseAuth = FirebaseAuth.instance;

    return Obx(
      () => Scaffold(
        backgroundColor: UIColors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: paddingHorizontal,
              right: paddingHorizontal,
              top: paddingTop,
            ),
            child: SingleChildScrollView(
              physics: MediaQuery.of(context).viewInsets.bottom > 0
                  ? const ScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Image.asset(
                      ImagePath.logoIpsum,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: paddingTop * 2,
                    ),
                    // Form alanları
                    Column(
                      children: [
                        Row(
                          children: [
                            BasicText(
                              title: LocaleKeys.login,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ],
                        ),
                        SizedBox(height: paddingTop / 2),
                        CustomTextField(
                          onSaved: (value) {
                            email = value ?? '';
                          },
                          focusNode: loginController.emailFocusNode,
                          nextFocusNode: loginController.passwordFocusNode,
                          showIcon: false,
                          controller: loginController.emailController,
                          onChanged: (p0) {
                            loginController.isEmail(loginController.emailController.text);
                            loginController.emailBorderColor =
                                loginController.getEmailBorderColor(loginController.emailController.text);
                          },
                          borderSideColors: loginController.emailBorderColor.value,
                          backgroundColor: loginController.isValidEmail.value
                              ? UIColors.noErrorColor
                              : UIColors.errorColor,
                          hintText: LocaleKeys.hintTextMail,
                          obscureText: false,
                        ),
                        loginController.isValidEmail.value
                            ? Container()
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: BasicText(
                                  titleColor: UIColors.errorMessageColor,
                                  title: UIText.errorMessageEmail,
                                  fontSize: 12,
                                ),
                              ),
                        SizedBox(height: paddingTop / 5),
                        CustomTextField(
                          onSaved: (value) {
                            password = value ?? '';
                          },
                          focusNode: loginController.passwordFocusNode,
                          showIcon: true,
                          controller: loginController.passwordController,
                          onChanged: (p0) {
                            loginController.isPassword(loginController.passwordController.text);
                            loginController.passwordBorderColor =
                                loginController.getpasswordBorderColor(loginController.passwordController.text);
                          },
                          borderSideColors: loginController.passwordBorderColor.value,
                          backgroundColor: loginController.isCorrectPassword.value
                              ? UIColors.errorColor
                              : UIColors.noErrorColor,
                          hintText: LocaleKeys.hintTextPassword,
                          obscureText: true,
                        ),
                        loginController.isCorrectPassword.value
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: BasicText(
                                  titleColor: UIColors.errorMessageColor,
                                  title: UIText.errorMessagePassword,
                                  fontSize: 12,
                                ),
                              )
                            : Container(),
                        SizedBox(height: paddingTop / 5),
                        const RemembermeForgetpassword(),
                        SizedBox(height: paddingTop / 2),
                        // Buton ve Yükleniyor Durumu
                        Obx(() {
                          return loginController.isLoading.value
                              ? const CircularProgressIndicator()
                              : ButtonBasic(
                                  text: LocaleKeys.login,
                                  func: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save(); // Form verilerini kaydet
                                      try {
                                        var userResult = await fireBaseAuth.signInWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );
                                        loginController.login();
                                      } catch (e) {
                                        Get.snackbar("Hata", "Kayıtlı Kullanıcı Bulunamadı!! ");
                                        print(e.toString());
                                      }
                                    }
                                  },
                                );
                        }),
                        const Customdivider(),
                        OtherLoginButtons(),
                      ],
                    ),
                    SizedBox(
                      height: paddingTop * 1.5,
                    ),
                    const Ifyoudonthaveaccound(),
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
