import 'package:flutter/material.dart';
import 'package:telefon_rehberi/widget/basic_text.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';

class Customdivider extends StatelessWidget {
  const Customdivider({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;

    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop / 3,
        bottom: paddingTop /3
      ),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          SizedBox(
            width: paddingHorizontal / 2,
          ),
          const BasicText(title: LocaleKeys.or),
          SizedBox(
            width: paddingHorizontal / 2,
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}
