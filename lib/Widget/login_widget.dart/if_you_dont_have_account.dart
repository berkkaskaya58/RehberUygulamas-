import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:telefon_rehberi/widget/basic_text.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/view/view_sign_up/sign_up_page.dart';

class Ifyoudonthaveaccount extends StatelessWidget {
  const Ifyoudonthaveaccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BasicText(
          title: LocaleKeys.ifYouDoNotHaveAccound,
          fontSize: 14,
        ),
        GestureDetector(
            onTap: () {
              Get.offAll(() => const SignPage());
            },
            child: const BasicText(
              title: LocaleKeys.createAccound,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}
