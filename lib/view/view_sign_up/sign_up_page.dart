import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/controller/sign_up_controller.dart';
import 'package:telefon_rehberi/widget/basic_text.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_images.dart';
import 'package:telefon_rehberi/widget/if_you_have_account.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/custom_divider.dart';
import 'package:telefon_rehberi/widget/login_widget.dart/other_login_buttons.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';
import 'package:telefon_rehberi/widget/widget_basic_text_field.dart';


class SignPage extends StatelessWidget {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());

    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double paddingBottom = MediaQuery.of(context).size.height * 0.05;

    return Obx(
      () => Scaffold(
        key: signUpController.globalKey,
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
              key: signUpController.signFormKey,
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
                      child: const Row(
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
                        signUpController.name = value;
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
                        signUpController.email = value;
                      },
                      focusNode: signUpController.emailFocusNode,
                      nextFocusNode: signUpController.passwordFocusNode,
                      showIcon: false,
                      controller: signUpController.emailController,
                      onChanged: (p0) {
                        signUpController
                            .isEmail(signUpController.emailController.text);
                        signUpController.emailBorderColor =
                            signUpController.getEmailBorderColor(
                                signUpController.emailController.text);
                      },
                      borderSideColors: signUpController.getEmailBorderColor(
                          signUpController.emailController.text),
                      hintText: LocaleKeys.hintTextMail,
                      obscureText: false,
                      backgroundColor: signUpController.getEmailBackgroundColor(
                          signUpController.emailController.text),
                    ),
                    signUpController.isValidEmail.value
                        ? Container()
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: BasicText(
                              titleColor: UIColors.errorMessageColor,
                              title: LocaleKeys.errorMessageEmail,
                              fontSize: 12,
                            )),
                    SizedBox(height: paddingTop / 4),
                    CustomTextField(
                      onSaved: (value) {
                        signUpController.password = value;
                      },
                      focusNode: signUpController.passwordFocusNode,
                      nextFocusNode: signUpController.password2FocusNode,
                      showIcon: true,
                      controller: signUpController.passwordController,
                      onChanged: (p0) {
                        signUpController.isPassword(
                            signUpController.passwordController.text);
                        signUpController.isPasswordEqual();
                      },
                      borderSideColors:
                         signUpController.getpasswordBorderColor(signUpController.passwordController.text),
                      hintText: LocaleKeys.hintTextPassword,
                      obscureText: true,
                      backgroundColor:
                         signUpController.getPasswordBackgroundColor(signUpController.passwordController.text)
                    ),
                    signUpController.isCorrectPassword.value
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: BasicText(
                              titleColor: UIColors.errorMessageColor,
                              title: LocaleKeys.errorMessagePassword,
                              fontSize: 12,
                            ),
                          )
                        : Container(),
                    SizedBox(height: paddingTop / 4),
                    CustomTextField(
                      onSaved: (value) {
                        signUpController.password2 = value ;
                      },
                      focusNode: signUpController.password2FocusNode,
                      showIcon: true,
                      controller: signUpController.passwordController2,
                      onChanged: (p0) {
                        signUpController.isPasswordEqual();
                      },
                      borderSideColors:
                          signUpController.getPassword2BorderColor(),
                      hintText: LocaleKeys.hintTextThePasswordAgain,
                      obscureText: true,
                      backgroundColor:
                        signUpController.getPassword2BackgroundColor(signUpController.passwordController2.text,signUpController.passwordController.text),
                    ),
                    signUpController.areSamePasswords.value
                        ? Container()
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: BasicText(
                              titleColor: UIColors.errorMessageColor,
                              title: LocaleKeys.notSamePassword,
                              fontSize: 12,
                            ),
                          ),
                    SizedBox(height: paddingTop * 1.5),
                    ButtonBasic(
                      func: () async {
                        signUpController.signUpWithEmailAndPassword();
                      },
                      text: LocaleKeys.signUp,
                    ),
                    const Customdivider(),
                    const OtherLoginButtons(),
                    SizedBox(height: paddingTop/2 ),
                    const IfYouHaveAccount()
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
