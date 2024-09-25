import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/controller/edit_people_controller.dart';
import 'package:telefon_rehberi/view/view_home/bottom_navigation_bar.dart';
import 'package:telefon_rehberi/widget/basic_text.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/widget/widget_basic_text_field.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';

// ignore: must_be_immutable
class EditPerson extends StatelessWidget {
  List<DocumentSnapshot<Object?>> list;
  int index;
  EditPerson({super.key, required this.list, required this.index});

 

  @override
  Widget build(BuildContext context) {
final editPeopleController = Get.put(EditPeopleController(index: index, list: list),);

    // var data = list[index].data() as Map<String, dynamic>;

    //  editPeopleController.nameController.text = data['name'];
    // editPeopleController.numberController.text = data['number'];
    // editPeopleController.emailController.text = data['email'];

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
                    const Align(
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
                      onTap: editPeopleController.selectImage,
                      child: Obx(() {
                        return editPeopleController.images.isEmpty
                            ? Image.asset(IconPath.addPhoto)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  File(editPeopleController.images.first.path),
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
                  controller: editPeopleController.nameController,
                  hintText: LocaleKeys.hintTextNameSurname,
                  obscureText: false,
                  focusNode: editPeopleController.nameFocusNode,
                  nextFocusNode: editPeopleController.numberFocusNode,
                  onChanged: (value) {
                    editPeopleController.nameController.text = value;
                  },
                ),
                SizedBox(height: paddingTop / 5),
                CustomTextField(
                  showIcon: false,
                  controller: editPeopleController.numberController,
                  hintText: LocaleKeys.phoneNumber,
                  obscureText: false,
                  focusNode: editPeopleController.numberFocusNode,
                  nextFocusNode: editPeopleController.eMailFocusNode,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11), // Maksimum 11 rakam
                    FilteringTextInputFormatter
                        .digitsOnly, // Sadece rakam girişi
                  ],
                  onChanged: (value) {
                    editPeopleController.numberController.text = value;
                  },
                ),
                SizedBox(height: paddingTop / 5),
                GestureDetector(
                  onTap: editPeopleController.addPhoneNumber,
                  child: const Row(
                    children: [
                      ImageIcon(AssetImage(IconPath.add)),
                      SizedBox(width: 8),
                      BasicText(
                          title: LocaleKeys.addOneMoreNumber, fontSize: 14),
                    ],
                  ),
                ),
                SizedBox(height: paddingTop / 5),
                CustomTextField(
                    focusNode: editPeopleController.eMailFocusNode,
                    showIcon: false,
                    controller: editPeopleController.emailController,
                    onChanged: (value) {
                      editPeopleController.isEmail(value);
                      editPeopleController.emailBorderColor =
                          editPeopleController.getEmailBorderColor(value);
                    },
                    borderSideColors: editPeopleController.getEmailBorderColor(
                        editPeopleController.emailController.text),
                    hintText: LocaleKeys.hintTextMail,
                    obscureText: false,
                    backgroundColor:
                        editPeopleController.getEmailBackgroundColor(
                            editPeopleController.emailController.text)),
                editPeopleController.isValidEmail.value
                    ? Container()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: BasicText(
                          titleColor: UIColors.errorMessageColor,
                          title: LocaleKeys.errorMessageEmail,
                          fontSize: 12,
                        ),
                      ),
                const Spacer(),
                ButtonBasic(
                  text: LocaleKeys.save.tr,
                  func: () async {
                    try {
                      await FirebaseFirestore.instance
                          .collection('FirebaseCollection')
                          .doc(list[index].id)
                          .update({
                        'name': editPeopleController.nameController.text,
                        'number': editPeopleController.numberController.text,
                        'email': editPeopleController.emailController.text,
                      });
                      Get.to(() => const CustomBottomNavigationBar());

                      Get.snackbar('', 'Kayıt başarılı ',
                          duration: const Duration(seconds: 1));
                    } catch (e) {
                      Get.snackbar(
                          '{$e}', 'Kayıt başarısız. Lütfen tekrar deneyin',
                          duration: const Duration(seconds: 1));
                    }
                  },
                ),
                SizedBox(height: paddingTop / 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
