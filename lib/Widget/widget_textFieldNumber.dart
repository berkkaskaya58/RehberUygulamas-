import 'package:flutter/material.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';

// ignore: must_be_immutable
class CustomTextFieldNumber extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  int? passwordLength;
  final Function? func;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  CustomTextFieldNumber({
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
  State<CustomTextFieldNumber> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldNumber> {
  @override
  Widget build(BuildContext context) {
    Color error() {
      if (widget.controller.text.isEmpty) {
        return UIColors.white; // Boşken varsayılan arka plan
      } else if (widget.controller.text.length != 11) {
        return UIColors.errorColor; // Hatalı uzunlukta
      } else {
        return UIColors.noErrorColor; // Doğru uzunlukta
      }
    }

    Color errorBorder() {
      if (widget.controller.text.isEmpty) {
        return UIColors.borderColor; // Boşken varsayılan border
      } else if (widget.controller.text.length != 11) {
        return UIColors.errorBorderColor; // Hatalı uzunlukta border
      } else {
        return UIColors.noErrorBorderColor; // Doğru uzunlukta border
      }
    }

    double paddingTop = MediaQuery.sizeOf(context).height;

    return Column(
      children: [
        Container(
          width: 390,
          height: paddingTop / 15,
          child: TextField(
            focusNode: widget.focusNode,
            onSubmitted: (_) {
              if (widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              } else {
                FocusScope.of(context).unfocus();
              }
            },
            keyboardType: TextInputType.number,
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
                borderSide: BorderSide(color: errorBorder()),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: errorBorder()),
              ),
            ),
            onChanged: (text) {
              if (widget.func != null) {
                widget.func!(text);
              }
              setState(() {
                widget.passwordLength = text.length;
              });
            },
          ),
        ),
        // 11 karakterden farklıysa hata mesajı göster
        if (widget.controller.text.length != 11 && widget.controller.text.isNotEmpty)
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
