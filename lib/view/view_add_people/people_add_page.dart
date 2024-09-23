import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/controller/add_people_controller.dart';
import 'package:telefon_rehberi/widget/basic_text.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/widget/widget_basic_text_field.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';

class PeopleAdd extends StatefulWidget {
  const PeopleAdd({super.key});

  @override
  State<PeopleAdd> createState() => _PeopleAddState();
}

class _PeopleAddState extends State<PeopleAdd> {
  final addPeopleController = Get.put(AddPeopleController());

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
              right: paddingHorizontal,
            ),
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
                        title: LocaleKeys.addPerson,
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
                      onTap: addPeopleController.selectImage,
                      child: Obx(() {
                        return addPeopleController.uploadFile.value.isEmpty
                            ? Image.asset(IconPath.addPhoto)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  addPeopleController.uploadFile.value,
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
                  controller: addPeopleController.nameController,
                  hintText: LocaleKeys.hintTextNameSurname,
                  obscureText: false,
                  focusNode: addPeopleController.nameFocusNode,
                  nextFocusNode: addPeopleController.numberFocusNode,
                ),
                Padding(
                  padding: EdgeInsets.only(top: paddingTop / 3),
                  child: CustomTextField(
                   backgroundColor: UIColors.textFieldBackGround,
                    showIcon: false,
                    controller: addPeopleController.numberController,
                    hintText: LocaleKeys.phoneNumber,
                    obscureText: false,
                    focusNode: addPeopleController.numberFocusNode,
                    nextFocusNode: addPeopleController.emailFocusNode,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(height: paddingTop / 5),
                GestureDetector(
                  onTap: () {
                    addPeopleController.addPhoneNumber();
                  },
                  child: const Row(
                    children: [
                      ImageIcon(AssetImage(IconPath.add)),
                      SizedBox(width: 8),
                      BasicText(
                        title: LocaleKeys.addOneMoreNumber,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: paddingTop / 5),
                CustomTextField(
                  focusNode: addPeopleController.emailFocusNode,
                  showIcon: false,
                  controller: addPeopleController.emailController,
                  onChanged: (p0) {
                    addPeopleController.isEmail(addPeopleController.emailController.text);
                    addPeopleController.emailBorderColor.value =
                        addPeopleController.getEmailBorderColor(addPeopleController.emailController.text);
                  },
                  borderSideColors: addPeopleController.emailBorderColor.value,
                  hintText: LocaleKeys.hintTextMail,
                  obscureText: false,
                   backgroundColor: addPeopleController.getEmailBackgroundColor(addPeopleController.emailController.text),
                ),
               addPeopleController.isValidEmail.value
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
                  text: LocaleKeys.save,
                  func: () async {
                    addPeopleController.addPeople(); // Kişiyi ekle
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
