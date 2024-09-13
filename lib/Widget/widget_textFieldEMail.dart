import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:telefon_rehberi/main.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';

// ignore: must_be_immutable
class CustomTextFieldEMail extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  int? passwordLength;
  final Function? func;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final Function? onChanged;

  CustomTextFieldEMail({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.passwordLength,
    this.func,
    this.focusNode,
    this.nextFocusNode,
    this.onChanged,
  });

  @override
  State<CustomTextFieldEMail> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldEMail> {

  
  bool? isValidEmail; // Başlangıçta null olarak ayarlandı

  // Sadece .com ile biten e-posta adresleri için regex
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+(\.com)$');

  // E-posta doğrulama sonucuna göre geri dönen renk
  Color error() {
    if (widget.controller.text.isEmpty) {
      return UIColors.textFieldBackGround; // Boşsa varsayılan border
    } else if (isValidEmail == false) {
      return UIColors.noErrorColor; // Geçerliyse noError rengi
    } else {
      return UIColors.errorColor; // Geçersizse error rengi
    }
  }

  // E-posta doğrulama sonucuna göre border rengi
  Color errorBorder() {
    if (widget.controller.text.isEmpty) {
      return UIColors.borderColor; // Boşsa varsayılan border
    } else if (isValidEmail == false) {
      return UIColors.noErrorBorderColor; // Geçerliyse noError rengi
    } else {
      return UIColors.errorBorderColor; // Geçersizse error rengi
    }
  }

  @override
  Widget build(BuildContext context) {
    
    double paddingTop = MediaQuery.sizeOf(context).height; //
    return Column(
      children: [
        Container(
          width: 390,
          height: paddingTop / 15,
          child: TextField(
            
            focusNode: widget.focusNode,
            onSubmitted: (_) {
              if (widget.nextFocusNode != null) {
                FocusScope.of(context)
                    .requestFocus(widget.nextFocusNode); // Sonraki focus'a geçiş
              } else {
                FocusScope.of(context).unfocus(); // Fokus kaybı
              }
            },
            keyboardType: TextInputType.emailAddress,
            controller: widget.controller,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(14.0),
              fillColor: error(), // Renk kontrolü
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: UIColors.hintText,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                  color: errorBorder(), // Border rengi
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                  color: errorBorder(),
                ),
              ),
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.obscureText = !widget.obscureText;
                        });
                      },
             child: Image.asset(
                        widget.obscureText ? IconPath.eye : IconPath.eyeClosed,
                      ),
                    )
                  : null,
            ),
            onChanged: (text) {
              if (widget.onChanged != null) {
                widget.onChanged!(text);
              }

              setState(() {
                // E-posta formatı kontrolü
                if (text.contains('@') && text.endsWith('.com')) {
                  isValidEmail = false;
                } else if(text.isEmpty){
                  isValidEmail = false;
                }
                else{
                  isValidEmail = true;
                }
              });
            },
          ),
        ),
        if (isValidEmail == true ) // Hata mesajını sadece geçersiz e-posta varsa göster
          Row(
            children: [
              Text(
                UIText.errorMessage,
                style: TextStyle(color: UIColors.errorMessageColor),
              ).tr(),
            ],
          ),
     
      ],
    );
  }
}
