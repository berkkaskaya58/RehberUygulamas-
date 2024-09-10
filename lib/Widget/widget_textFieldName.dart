import 'package:flutter/material.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';

// ignore: must_be_immutable
class CustomTextFieldName extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  int? passwordLength;
  final Function? func;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
   


  CustomTextFieldName({
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
  State<CustomTextFieldName> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldName> {
  @override
  Widget build(BuildContext context) {
     double paddingTop = MediaQuery.sizeOf(context).height; //

   Color error() {
  if (widget.controller.text.length==0) {
    return UIColors.textFieldBackGround;  
  } 
  else if(widget.controller.text.length != 0 && widget.controller.text.length < 20){
return UIColors.noErrorColor;
  }
  else {
    return UIColors.errorColor;
  }
}

      Color errorBorder() {
      if (widget.controller.text.length==0) {
    return UIColors.borderColor;  
  } 
  else if(widget.controller.text.length != 0 && widget.controller.text.length < 20){
return UIColors.noErrorBorderColor;
  }
  else {
    return UIColors.errorBorderColor;
  }
    }
    return Column(
      children: [
        Container(
          width: 390,
          height: paddingTop/15,
          child: TextField(
            focusNode: widget.focusNode,
            onSubmitted: (_) {
              if (widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);    //???
              } else {
                // Eğer bir sonraki FocusNode yoksa, odaklanmayı bitirin
                FocusScope.of(context).unfocus();
              }
            },
            keyboardType: TextInputType.name,
            controller: widget.controller,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(14.0),
              fillColor:error(),
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: UIColors.hintText),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                  color: errorBorder()
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                  color:errorBorder()
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
              if (widget.func != null) {
                widget.func!(text);
              }
              setState(() {
                widget.passwordLength = text.length;
              });
            },
          ),
        ),
        if(widget.controller.text.length>19)

        Row(children: [
           Text(
                UIText.errorMessage, 
                style: TextStyle(color: UIColors.errorMessageColor),
              ),
        ],),
      ],
    );
  }
}
