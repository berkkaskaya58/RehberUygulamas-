import 'package:flutter/material.dart';
import 'package:telefon_rehberi/widget/basicText.dart';
import 'package:telefon_rehberi/widget/widget_checkBox.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';

class RemembermeForgetpassword extends StatelessWidget {
  const RemembermeForgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
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
        BasicText(
          title: LocaleKeys.forgetPassword,
          fontSize: 12,
        ),
      ],
    );
  }
}
