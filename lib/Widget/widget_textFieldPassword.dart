import 'package:flutter/material.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';

// ignore: must_be_immutable
class CustomTextFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  final int? passwordLength;
  final Function? func;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  CustomTextFieldPassword({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.passwordLength,
    this.func,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  State<CustomTextFieldPassword> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    // Şifre uzunluğuna göre arka plan rengi
    Color error() {
      if (widget.controller.text.isEmpty) {
        return UIColors.white; // Boşken varsayılan arka plan
      } else if (widget.controller.text.length <= 8) {
        return UIColors.noErrorColor; // Şifre 8 karakter ya da daha küçükse
      } else {
        return UIColors.errorColor; // Şifre uzunluğu 8'den büyükse
      }
    }

    // Şifre uzunluğuna göre border rengi
    Color errorBorder() {
      if (widget.controller.text.isEmpty) {
        return UIColors.borderColor; // Boşken varsayılan border
      } else if (widget.controller.text.length <= 8) {
        return UIColors.noErrorBorderColor; // Şifre 8 karakter ya da daha küçükse
      } else {
        return UIColors.errorBorderColor; // Şifre uzunluğu 8'den büyükse
      }
    }

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
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(14.0),
              fillColor: error(), // Arka plan rengi kontrolü
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: UIColors.hintText),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: errorBorder()), // Border rengi kontrolü
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: errorBorder()), // Border rengi kontrolü
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText; // Şifreyi göster/gizle
                  });
                },
                child: ImageIcon(
                  AssetImage(widget.obscureText ? IconPath.eye : IconPath.eyeClosed), // Göz simgesi
                ),
              ),
            ),
            onChanged: (text) {
              if (widget.func != null) {
                widget.func!(text);
              }
              setState(() {
                // Şifre uzunluğunu dinamik olarak güncelle
              });
            },
          ),
        ),
        if (widget.controller.text.length > 8) 
          Row(
            children: [
              Text(
                UIText.errorMessage, 
                style: TextStyle(color: UIColors.errorMessageColor),
              ),
            ],
          ),
      ],
    );
  }
}
