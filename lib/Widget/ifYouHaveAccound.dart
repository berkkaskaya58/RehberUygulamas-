import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:telefon_rehberi/view/view_login/login_page.dart';
import 'package:telefon_rehberi/widget/basicText.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';

class IfYouHaveAccound extends StatelessWidget {
  const IfYouHaveAccound({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BasicText(
                        title: LocaleKeys.ifYouDoHaveAccound,
                        fontSize: 14,
                      ),
                      GestureDetector(
                          onTap: () {
                         Get.to(() => LoginPage());

                          },
                          child: BasicText(
                            title: LocaleKeys.login,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  );
  }
}