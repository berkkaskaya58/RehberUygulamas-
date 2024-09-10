import 'package:flutter/material.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';

class CustomCheckBox extends StatefulWidget {
  CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked; 
        });
      },
      child: Image.asset(
        _isChecked ? IconPath.checkSquare : IconPath.noCheckSquare, 
        width: 20,
        height: 20,
      ),
    );
  }
}
