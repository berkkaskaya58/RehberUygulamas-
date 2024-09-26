import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/controller/add_people_controller.dart';
import 'package:telefon_rehberi/ui/ui_images.dart';
import 'package:telefon_rehberi/widget/basic_text.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';
import 'package:telefon_rehberi/widget/widget_container.dart';
import 'package:telefon_rehberi/controller/people_deatil_controller.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
// import 'package:telefon_rehberi/model/user_model.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/view/view_edit_people/people_edit_page.dart';

class PeopleDetail extends StatelessWidget {
  final List<DocumentSnapshot<Object?>> list;
  // final UsersModelData? model;
  final int index;
  final addPeopleController = Get.put(AddPeopleController());

  PeopleDetail({
    super.key,
    // this.model,
    required this.list,
    required this.index,
  });


  @override
  Widget build(BuildContext context) {
  final peopleDetailController = Get.put(PeopledeatilController(list: list,index: index));

    var data = list[index].data() as Map<String, dynamic>;

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
                        child: const BasicText(
                          title: LocaleKeys.personDetail,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const ImageIcon(
                        color: Colors.transparent,
                        AssetImage(IconPath.addPhoto),
                      ),
                    ],
                  ),
                  // Kullanıcının profil resmini göster
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: peopleDetailController.selectImage,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            data['profileImageUrl'] ?? ImagePath.notFound404, // Profil resmi URL'si
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: paddingTop),
                  Text(data['name'] ?? 'No Name', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: paddingTop / 30),
                  Text(data['number'] ?? 'No Number', style: const TextStyle(fontSize: 16)),
                  SizedBox(height: paddingTop),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          peopleDetailController.message();
                        },
                        child: const SquareContainer(
                          text: LocaleKeys.message,
                          imagePath: IconPath.message,
                        ),
                      ),
                      SizedBox(width: paddingHorizontal / 2),
                      GestureDetector(
                        onTap: () {
                          peopleDetailController.makePhoneCall();
                        },
                        child: const SquareContainer(
                          imagePath: IconPath.phone,
                          text: LocaleKeys.phone,
                        ),
                      ),
                      SizedBox(width: paddingHorizontal / 2),
                      const SquareContainer(
                        imagePath: IconPath.video,
                        text: LocaleKeys.withVideo,
                      ),
                      SizedBox(width: paddingHorizontal / 2),
                      GestureDetector(
                        onTap: () {
                          peopleDetailController.eMail();
                        },
                        child: const SquareContainer(
                          imagePath: IconPath.ePosta,
                          text: LocaleKeys.hintTextMail,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: paddingTop * 1.5),
                  GestureDetector(
                    child: ButtonBasic(
                      mainAxisAlignment: MainAxisAlignment.start,
                      prefixPath: IconPath.pen2,
                      color: UIColors.white,
                      titleColor: UIColors.black,
                      text: LocaleKeys.editPerson,
                      fontSize: 14,
                      func: () {
                        Get.to(
                          () => EditPerson(
                            index: index,
                            list: list,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: paddingTop),
                  ButtonBasic(
                    mainAxisAlignment: MainAxisAlignment.start,
                    prefixPath: IconPath.share,
                    color: UIColors.white,
                    titleColor: UIColors.black,
                    text: LocaleKeys.sharePerson,
                    fontSize: 14,
                    func: () {},
                  ),
                  SizedBox(height: paddingTop),
                  ButtonBasic(
                    mainAxisAlignment: MainAxisAlignment.start,
                    prefixPath: IconPath.star,
                    color: UIColors.white,
                    titleColor: UIColors.black,
                    text: LocaleKeys.addQuickSearch,
                    fontSize: 14,
                    func: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
