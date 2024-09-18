import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/controller/edit_people_controller.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';
import 'package:telefon_rehberi/widget/basicText.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/widget/widget_basic_text_field.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';

class EditPerson extends StatelessWidget {
  EditPerson({super.key});

  // Controller'ı burada tanımlayın
  final editPeopleCntroller = Get.put(EditPeopleController());

  File? _imagePath;

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double paddingBottom = MediaQuery.of(context).size.height * 0.05;

    return Obx(
      () => Scaffold(
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
                      child: BasicText(
                        title: LocaleKeys.editPerson,
                        fontWeight: FontWeight.w500,
                      ),
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
                      onTap: editPeopleCntroller.selectImage,
                      child: Obx(() {
                        return editPeopleCntroller.images.isEmpty
                            ? Image.asset(IconPath.addPhoto)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  File(editPeopleCntroller.images.first.path),
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                ),
                              );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: paddingTop / 2),
                CustomTextField(
                    showIcon: false,
                    controller: editPeopleCntroller.nameController,
                    hintText: LocaleKeys.hintTextNameSurname,
                    obscureText: false,
                    focusNode: editPeopleCntroller.nameFocusNode,
                    nextFocusNode: editPeopleCntroller.numberFocusNode),
                ...editPeopleCntroller.phoneNumberControllers
                    .asMap()
                    .entries
                    .map((entry) {
                  int index = entry.key;
                  return Padding(
                    padding: EdgeInsets.only(top: paddingTop / 3),
                    child: CustomTextField(
                      showIcon: false,
                      controller: entry.value,
                      hintText: LocaleKeys.phoneNumber,
                      obscureText: false,
                      focusNode:
                         editPeopleCntroller.numberFocusNode,
                         nextFocusNode: editPeopleCntroller.eMailFocusNode,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            11), // Maksimum 11 rakam
                        FilteringTextInputFormatter
                            .digitsOnly, // Sadece rakam girişi
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: paddingTop / 5),
                GestureDetector(
                  onTap: editPeopleCntroller.addPhoneNumber,
                  child: Row(
                    children: [
                      const ImageIcon(AssetImage(IconPath.add)),
                      const SizedBox(width: 8),
                      BasicText(
                          title: LocaleKeys.addOneMoreNumber, fontSize: 14),
                    ],
                  ),
                ),
                SizedBox(height: paddingTop / 5),
                CustomTextField(
                  focusNode: editPeopleCntroller.eMailFocusNode,
                  showIcon: false,
                  controller: editPeopleCntroller.emailController,
                  onChanged: (p0) {
                    editPeopleCntroller
                        .isEmail(editPeopleCntroller.emailController.text);
                    editPeopleCntroller.emailBorderColor =
                        editPeopleCntroller.getEmailBorderColor(
                            editPeopleCntroller.emailController.text);
                  }, // Fonksiyonu onChanged'de kullan
                  borderSideColors:
                      editPeopleCntroller.emailBorderColor.value,
                  hintText: LocaleKeys.hintTextMail,
                  obscureText: false,
                  backgroundColor: editPeopleCntroller.isValidEmail.value
                      ? UIColors.noErrorColor
                      : UIColors.errorColor,
                ),
                editPeopleCntroller.isValidEmail.value
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: BasicText(
                          titleColor: UIColors.errorMessageColor,
                          title: UIText.errorMessageEmail,
                          fontSize: 12,
                        )),
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
      ),
    );
  }
}
