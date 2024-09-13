import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:telefon_rehberi/widget/basicText.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/view/view_sign_up/sign_up_page.dart';

class Ifyoudonthaveaccound extends StatelessWidget {
  const Ifyoudonthaveaccound({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BasicText(
                        title: LocaleKeys.ifYouDoNotHaveAccound,
                        fontSize: 14,
                      ),
                      GestureDetector(
                          onTap: () {
                         Get.to(() => SignPage());

                          },
                          child: BasicText(
                            title: LocaleKeys.createAccound,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  );
  }
}