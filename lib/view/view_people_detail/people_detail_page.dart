import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/widget/basicText.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';
import 'package:telefon_rehberi/widget/widget_container.dart';
import 'package:telefon_rehberi/controller/peopleDeatil_controller.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/model/user_model.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/view/view_edit_people/people_edit_page.dart';

class PeopleDetail extends StatelessWidget {
   
   UsersModelData? model;
  PeopleDetail({super.key,  this.model});

  final peopleDetailController = Get.put(PeopledeatilController());

  

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).size.height * 0.015;
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingBottom = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      backgroundColor: UIColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: paddingHorizontal,
              right: paddingHorizontal,
              top: paddingTop),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: paddingTop,
                  bottom: paddingBottom,
                  left: paddingHorizontal / 5,
                  right: paddingHorizontal / 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          IconPath.clock,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: paddingHorizontal),
                        child: BasicText(title:  LocaleKeys.personDetail,fontWeight: FontWeight.w500,)
                      ),
                      const ImageIcon(
                        color: Colors.transparent,
                        AssetImage(IconPath.addPhoto),
                      ),
                    ],
                  ),
                 ClipOval(
                  
                  child: Image.network(model?.avatar ?? '')),


                  SizedBox(
                    height: paddingTop,
                  ),
                Text(model?.firstName ?? ''), 
                  SizedBox(
                    height: paddingTop / 30,
                  ),
                  Text(model?.email ?? ''),
                  SizedBox(
                    height: paddingTop,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                         
                          peopleDetailController.message();
                        },
                        child: SquareContainer(
                          text: LocaleKeys.message,
                          imagePath: IconPath.message,
                        ),
                      ),
                      SizedBox(
                        width: paddingHorizontal / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                         peopleDetailController.makePhoneCall();
                        },
                        child: SquareContainer(
                          imagePath: IconPath.phone,
                          text: LocaleKeys.phone,
                        ),
                      ),
                      SizedBox(
                        width: paddingHorizontal / 2,
                      ),
                      SquareContainer(
                        imagePath: IconPath.video,
                        text: LocaleKeys.withVideo,
                      ),
                      SizedBox(
                        width: paddingHorizontal / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                         peopleDetailController.eMail();
                        },
                        child: SquareContainer(
                          imagePath: IconPath.ePosta,
                          text: LocaleKeys.hintTextMail,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: paddingTop * 1.5,
                  ),
                  GestureDetector(
                    child: ButtonBasic(
                        heigth: 58,
                        mainAxisAlignment: MainAxisAlignment.start,
                        prefixPath: IconPath.pen2,
                        color: UIColors.white,
                       titleColor: UIColors.black,
                        text: LocaleKeys.editPerson,
                         fontSize: 14,
                        func: () {
                         Get.to(EditPerson());
                        }),
                  ),
                  SizedBox(
                    height: paddingTop,
                  ),
                  ButtonBasic(
                      heigth: 58,
                      mainAxisAlignment: MainAxisAlignment.start,
                      prefixPath: IconPath.share,
                      color: UIColors.white,
                       titleColor: UIColors.black,
                      text: LocaleKeys.sharePerson,
                      fontSize: 14,
                      func: () {}),
                  SizedBox(
                    height: paddingTop,
                  ),
                  ButtonBasic(
                      heigth: 58,
                      mainAxisAlignment: MainAxisAlignment.start,
                      prefixPath: IconPath.star,
                      color: UIColors.white,
                       titleColor: UIColors.black,
                      text: LocaleKeys.addQuickSearch,
                       fontSize: 14,
                      func: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
