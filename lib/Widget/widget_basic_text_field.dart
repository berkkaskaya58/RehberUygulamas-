import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final Function(String)? onChanged;
  final Color? borderSideColors;
  final Function(String)? errorMessage;
  final Color? backgroundColor;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.focusNode,
    this.nextFocusNode,
    this.onChanged,
    this.borderSideColors, 
    this.errorMessage,
    this.backgroundColor,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 48,
          child: TextField(
            
            focusNode: widget.focusNode,
            onSubmitted: (_) {
              if (widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode); // Sonraki focus'a geçiş
              } else {
                FocusScope.of(context).unfocus(); // Fokus kaybı
              }
            },
            
            keyboardType: TextInputType.visiblePassword,
            controller: widget.controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              
              contentPadding: const EdgeInsets.all(14.0),
              fillColor: widget.backgroundColor?? UIColors.white  ,
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: UIColors.hintText),
              enabledBorder: OutlineInputBorder(
             
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: widget.borderSideColors ?? UIColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: widget.borderSideColors ?? UIColors.borderColor),
              ),
              suffixIcon: GestureDetector(
                onTap: _toggleObscureText,
                child: ImageIcon(
                  AssetImage(obscureText ? IconPath.eye : IconPath.eyeClosed), // Göz simgesi
                ),
              ),
            ),
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
          ),
        ),
        if (widget.errorMessage != null)
          Row(
            children: [
              Text(
                widget.errorMessage!(widget.controller.text),
                style: TextStyle(color: UIColors.errorMessageColor),
              ),
            ],
          ),
      ],
    );
  }
}
