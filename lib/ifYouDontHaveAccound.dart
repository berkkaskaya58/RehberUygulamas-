import 'package:flutter/material.dart';
import 'package:telefon_rehberi/Widget/basicText.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/page/sign_page.dart';

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignPage(),
                              ),
                            );
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