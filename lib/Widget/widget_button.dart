import 'package:flutter/material.dart';
import 'package:telefon_rehberi/Widget/basicText.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';

class ButtonBasic extends StatelessWidget {
  String text = "";
  Color? color;
  Color? textColor;
  Function func;
  double? heigth;
  String? prefixPath;
  String? suffixPath;
  double? fontSize;
  final MainAxisAlignment mainAxisAlignment;
  Color? titleColor;
  FontWeight? fontWeight;

  ButtonBasic(
      {super.key,
      required this.text,
      required this.func,
      this.color,
      this.textColor,
      this.prefixPath,
      this.suffixPath,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.heigth,
      this.fontSize,
      this.titleColor,
      this.fontWeight
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          func();
        },
        child: Container(
          height: heigth ?? 52,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: UIColors.borderColor),
            color: color ?? UIColors.primary,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                prefixPath != null
                    ? Image.asset(
                        prefixPath ?? "",
                      )
                    : Container(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: BasicText(
                      title: text,
                      titleColor: titleColor ?? UIColors.white,
                      fontSize: fontSize ?? 18,
                      fontWeight: fontWeight?? FontWeight.w400,
                    )),
                suffixPath != null
                    ? Image.asset(
                        suffixPath ?? "",
                      )
                    : Container(),
              ],
            ),
          ),
        ));
  }
}
