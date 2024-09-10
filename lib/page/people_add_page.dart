import 'dart:io';
import 'package:flutter/material.dart';
import 'package:telefon_rehberi/Widget/basicText.dart';
import 'package:telefon_rehberi/future.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_font.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';
import 'package:telefon_rehberi/Widget/widget_button.dart';
import 'package:telefon_rehberi/Widget/widget_textFieldEMail.dart';
import 'package:telefon_rehberi/Widget/widget_textFieldName.dart';
import 'package:telefon_rehberi/Widget/widget_textFieldNumber.dart';

class PeopleAdd extends StatefulWidget {
  PeopleAdd({super.key});

  @override
  State<PeopleAdd> createState() => _PeopleAddState();
}

class _PeopleAddState extends State<PeopleAdd> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final List<TextEditingController> phoneNumberControllers = [
    TextEditingController()
  ];
  final List<FocusNode> phoneNumberFocusNodes = [FocusNode()]; // FocusNode listesi
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode eMailFocusNode = FocusNode();
  File? _imagePath;

  void _addPhoneNumberField() {
    setState(() {
      // Yeni controller ve focus node ekle
      phoneNumberControllers.add(TextEditingController());
      phoneNumberFocusNodes.add(FocusNode());

      
    
    });
  }

  Future<void> _selectImage() async {
    final pickedImage = await FutureVoid.pickImageFromGallery();
    setState(() {
      _imagePath = pickedImage;
    });
  }



  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double paddingBottom = MediaQuery.of(context).size.height * 0.05;

    return Scaffold(
      backgroundColor: UIColors.white,
      body: SingleChildScrollView(
        physics: MediaQuery.of(context).viewInsets.bottom > 0
            ? const ScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(
              top: paddingTop,
              left: paddingHorizontal,
              bottom: paddingBottom,
              right: paddingHorizontal),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      IconPath.clock,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                   child:BasicText(title:  LocaleKeys.addPerson,fontWeight: FontWeight.w500,)
                  ),
                  Image.asset(
                    IconPath.clock,
                    fit: BoxFit.cover,
                    color: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(height: paddingTop / 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _selectImage,
                    child: _imagePath == null
                        ? Image.asset(IconPath.addPhoto)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _imagePath!,
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: paddingTop / 2),
              CustomTextFieldName(
                controller: nameController,
                hintText: LocaleKeys.hintTextNameSurname,
                obscureText: false,
                focusNode: nameFocusNode,
                nextFocusNode: phoneNumberFocusNodes.isNotEmpty
                    ? phoneNumberFocusNodes.first
                    : null,
              ),
              ...phoneNumberControllers.asMap().entries.map((entry) {
                int index = entry.key;
                return Padding(
                  padding: EdgeInsets.only(top: paddingTop / 3),
                  child: CustomTextFieldNumber(
                    controller: entry.value,
                    hintText: LocaleKeys.phoneNumber,
                    obscureText: false,
                    focusNode: phoneNumberFocusNodes[index],
                    nextFocusNode: (index + 1 < phoneNumberFocusNodes.length)
                        ? phoneNumberFocusNodes[index + 1]
                        : eMailFocusNode,
                  ),
                );
              }).toList(),
              SizedBox(height: paddingTop / 5),
              GestureDetector(
                onTap: _addPhoneNumberField,
                child: Row(
                  children: [
                    ImageIcon(AssetImage(IconPath.add)),
                    const SizedBox(width: 8),
                   BasicText(title: LocaleKeys.addOneMoreNumber,fontSize: 14,),
                  ],
                ),
              ),
              SizedBox(height: paddingTop / 5),
              CustomTextFieldEMail(
                controller: emailController,
                hintText: LocaleKeys.ePosta,
                obscureText: false,
                focusNode: eMailFocusNode,
              ),
              const Spacer(),
              ButtonBasic(
                text: LocaleKeys.save,
                func: () {
                  // Kaydetme işlevini buraya ekleyebilirsiniz
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
