import 'package:flutter/material.dart';
import 'package:telefon_rehberi/Widget/widget_button.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_image.dart';

class OtherLoginButtons extends StatelessWidget {
  const OtherLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;

    return Column(
                          children: [
                            ButtonBasic(
                              prefixPath: ImagePath.google,
                              textColor: Colors.black,
                              color: UIColors.white,
                              text: LocaleKeys.loginWithGoogle,
                              titleColor: UIColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              func: () {},
                            ),
                            SizedBox(
                              height: paddingHorizontal / 1.5,
                            ),
                            ButtonBasic(
                              prefixPath: ImagePath.facebook,
                              textColor: Colors.black,
                              color: UIColors.white,
                              text: LocaleKeys.loginWithFacebook,
                              titleColor: UIColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              func: () {},
                            ),
                          ],
                        );
  }
}