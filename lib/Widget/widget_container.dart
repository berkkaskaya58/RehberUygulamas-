import 'package:flutter/material.dart';
import 'package:telefon_rehberi/widget/basicText.dart';

class SquareContainer extends StatelessWidget {
  final String text;
  final String imagePath;

  SquareContainer({super.key, required this.text, required this.imagePath});

  @override
  Widget build(BuildContext context) {
     double paddingHorizontal = MediaQuery.of(context).size.width *0.2;
    return Container(
      height: paddingHorizontal ,
      width: paddingHorizontal,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(AssetImage(imagePath)),
         BasicText(title: text,fontSize: 14,fontWeight: FontWeight.w600,)
        ],
      ),
    );
  }
}
