import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/widget/basic_text.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';
import 'package:telefon_rehberi/widget/widget_basic_text_field.dart';
import 'package:telefon_rehberi/controller/login_controller.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_images.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/custom_divider.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/if_you_dont_have_account.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/other_login_buttons.dart';

class LoginPage extends StatelessWidget {

  LoginPage({super.key, });

  final loginController =
      Get.put(LoginController()); // Controller'ı GetX ile bağla
  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;

    return Obx(
      () => Scaffold(
        key: loginController.globalKey,
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
                key: loginController.loginFormKey,
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
                        const Row(
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
                            loginController.email = value;
                          },
                          focusNode: loginController.emailFocusNode,
                          nextFocusNode: loginController.passwordFocusNode,
                          showIcon: false,
                          controller: loginController.emailController,
                          onChanged: (p0) {
                            loginController
                                .isEmail(loginController.emailController.text);
                            loginController.emailBorderColor =
                                loginController.getEmailBorderColor(
                                    loginController.emailController.text);
                          },
                          borderSideColors: loginController.getEmailBorderColor(
                              loginController.emailController.text),
                          backgroundColor:
                              loginController.getEmailBackgroundColor(
                                  loginController.emailController.text),
                          hintText: LocaleKeys.hintTextMail,
                          obscureText: false,
                        ),
                        loginController.isValidEmail.value
                            ? Container()
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: BasicText(
                                  titleColor: UIColors.errorMessageColor,
                                  title: LocaleKeys.errorMessageEmail,
                                  fontSize: 12,
                                ),
                              ),
                        SizedBox(height: paddingTop / 5),
                        CustomTextField(
                          onSaved: (value) {
                            loginController.password = value;
                          },
                          focusNode: loginController.passwordFocusNode,
                          showIcon: true,
                          controller: loginController.passwordController,
                          onChanged: (p0) {
                            loginController.isPassword(
                                loginController.passwordController.text);
                            loginController.passwordBorderColor =
                                loginController.getpasswordBorderColor(
                                    loginController.passwordController.text);
                          },
                          borderSideColors:
                              loginController.getpasswordBorderColor(
                                  loginController.passwordController.text),
                          backgroundColor:
                              loginController.getPasswordBackgroundColor(
                                  loginController.passwordController.text),
                          hintText: LocaleKeys.hintTextPassword,
                          obscureText: true,
                        ),
                        loginController.isCorrectPassword.value
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: BasicText(
                                  titleColor: UIColors.errorMessageColor,
                                  title: LocaleKeys.errorMessagePassword,
                                  fontSize: 12,
                                ),
                              )
                            : Container(),
                        SizedBox(height: paddingTop / 5),
                        getRememberMeandForgotPswrd(context),
                        SizedBox(height: paddingTop / 2),
                        // Buton ve Yükleniyor Durumu
                        Obx(() {
                          return loginController.isLoading.value
                              ? const CircularProgressIndicator()
                              : ButtonBasic(
                                  text: LocaleKeys.login,
                                  func: () async {
                                    loginController
                                        .signInWithEmailAndPassword();
                                  });
                        }),
                        const Customdivider(),
                        const OtherLoginButtons(),
                      ],
                    ),
                    SizedBox(
                      height: paddingTop * 1.5,
                    ),
                    const Ifyoudonthaveaccount(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
  }
 Widget getRememberMeandForgotPswrd(BuildContext context) {
   double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
               loginController.changeIsChacked();
                loginController.hiveLogin();
              },
              child: Obx(
                () => Image.asset(
                  loginController.isChecked.value
                      ? IconPath.checkSquare
                      : IconPath.noCheckSquare,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
             SizedBox(
              width: paddingHorizontal,
            ),
            const BasicText(
              title: LocaleKeys.rememberMe,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Şifre sıfırlama fonksiyonunu tetikliyoruz
            loginController.resetPassword();
          },
          child: const BasicText(
            title: LocaleKeys.forgetPassword,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
 
}
