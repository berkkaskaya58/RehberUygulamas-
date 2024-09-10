import 'dart:io';

import 'package:flutter/material.dart';
import 'package:telefon_rehberi/Widget/basicText.dart';
import 'package:telefon_rehberi/Widget/widget_button.dart';
import 'package:telefon_rehberi/future.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/page/people_edit_page.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/Widget/widget_container.dart';
import 'package:telefon_rehberi/ui/ui_font.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';
import 'package:telefon_rehberi/ui/ui_text.dart';
import 'package:url_launcher/url_launcher.dart';

class PeopleDetail extends StatefulWidget {
  PeopleDetail({super.key});

  @override
  State<PeopleDetail> createState() => _PeopleDetailState();
}

class _PeopleDetailState extends State<PeopleDetail> {
  File? _imagePath;
  final List<TextEditingController> phoneNumberControllers = [
    TextEditingController()
  ];

  void _addPhoneNumberField() {
    setState(() {
      phoneNumberControllers.add(TextEditingController());
    });
  }

  Future<void> _selectImage() async {
    final pickedImage = await FutureVoid.pickImageFromGallery();
    setState(() {
      _imagePath = pickedImage;
    });
  }



  Future<void> message() async {
   

    final Uri launchUri = Uri(
      scheme: 'sms',
      path: '+904445553525', // Boşluk olmadan
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print("Could not launch $launchUri");
    }
  }
  static Future<void> eMail() async {
    final Uri launchUri = Uri(scheme: 'mailto', path:'berkkaskaya01@gmail.com' );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print("Could not launch $launchUri");
    }
  }
    static Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path:'+904445553525' );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print("Could not launch $launchUri");
    }
  }
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
                  Image.asset(IconPath.addPhoto),
                  SizedBox(
                    height: paddingTop,
                  ),
                  Text("Annem"),
                  SizedBox(
                    height: paddingTop / 30,
                  ),
                  Text("+90 4445553525"),
                  SizedBox(
                    height: paddingTop,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                         
                          message();
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
                          makePhoneCall();
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
                          eMail();
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPerson(),
                              ));
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
