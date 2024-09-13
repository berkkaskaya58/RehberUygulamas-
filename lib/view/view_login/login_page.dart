import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:telefon_rehberi/textField_error_controller.dart';
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

  final textFieldErrorController =
      Get.put(TextfieldErrorController()); // Controller'ı GetX ile bağla
       final loginController =
      Get.put(LoginController()); // Controller'ı GetX ile bağla

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double paddingBottom = MediaQuery.of(context).size.height * 0.05;

    return Obx(
      () => Scaffold(
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
                    // Logo
                    Image.asset(
                      ImagePath.logoIpsum,
                      fit: BoxFit.contain,
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
                            )
                          ],
                        ),
                        SizedBox(height: paddingTop / 2),
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
                        SizedBox(height: paddingTop / 5),

                        CustomTextField(
                          controller: textFieldErrorController.passwordController,
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
                        SizedBox(height: paddingTop / 5),
                        const RemembermeForgetpassword(),
                        SizedBox(height: paddingTop / 2),

                        // Buton ve Yükleniyor Durumu
                        Obx(() {
                          return loginController.isLoading.value
                              ? const CircularProgressIndicator()
                              : ButtonBasic(
                                  text: LocaleKeys.login,
                                  func: loginController
                                      .login, // GetX login işlemi
                                );
                        }),

                        const Customdivider(),
                        const OtherLoginButtons(),
                        SizedBox(height: paddingTop / 5),
                      ],
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
