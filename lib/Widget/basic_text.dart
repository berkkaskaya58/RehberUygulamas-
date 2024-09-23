
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';

class BasicText extends StatelessWidget {

   final String title;
  final Color? titleColor;
  final FontWeight? fontWeight;
  final double? fontSize;
   const BasicText({super.key,required this.title, this.titleColor, this.fontWeight, this.fontSize});
 
  @override
  Widget build(BuildContext context) {
    return Text(

      title,
      style:TextStyle(color:titleColor ??UIColors.black,
      fontFamily: 'Inter',
      fontWeight: fontWeight?? FontWeight.w400,
      fontSize: fontSize??16,

      ),
    ).tr();
    
    
  }
}