import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';

// ignore: must_be_immutable
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
  final List<dynamic>? inputFormatters;
  final bool showIcon; // İkonun gösterilip gösterilmeyeceği
    String? keep;
    final Function(String)? onSaved;

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
    this.inputFormatters,
    this.showIcon = true, // Varsayılan olarak ikon gösterilecek
    this.keep,
    this.onSaved
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
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
        SizedBox(
          width: 390,
          height: 48,
          child: TextFormField(
            onSaved: (value) {
              if (widget.onSaved != null) {
                widget.onSaved!(value ?? ''); // onSaved fonksiyonunu çağırın
              }
            },
            focusNode: widget.focusNode,
            // onSubmitted: (_) {
            //   if (widget.nextFocusNode != null) {
            //     FocusScope.of(context).requestFocus(widget.nextFocusNode); // Sonraki focus'a geçiş
            //   } else {
            //     FocusScope.of(context).unfocus(); // Fokus kaybı
            //   }
            // },
            keyboardType: TextInputType.visiblePassword,
            controller: widget.controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(14.0),
              fillColor: widget.backgroundColor ?? UIColors.textFieldBackGround,
              filled: true,
              hintText: widget.hintText.tr(),
              hintStyle: TextStyle(color: UIColors.hintText),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: widget.borderSideColors ?? UIColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: widget.borderSideColors ?? UIColors.borderColor),
              ),
              // İkonun gösterilip gösterilmeyeceğini kontrol edin
              suffixIcon: widget.showIcon
                  ? GestureDetector(
                      onTap: _toggleObscureText,
                      child: obscureText
                          ? const ImageIcon(
                              AssetImage(IconPath.eye),
                            )
                          : const ImageIcon(
                             
                             AssetImage(IconPath.eyeClosed),),
                    )
                  : null,
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
