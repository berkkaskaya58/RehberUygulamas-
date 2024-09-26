import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/controller/home_controller.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_images.dart';
import 'package:telefon_rehberi/view/view_add_people/people_add_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
   
      final homeController=Get.put(HomeController());
    return Scaffold(
      backgroundColor: UIColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 47),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 132.8,
                    child: Image.asset(ImagePath.logoIpsum),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PeopleAdd(),
                        ),
                      );
                    },
                    child: Image.asset(ImagePath.addPeople),
                  ),
                ],
              ),
             homeController.ContactList(),
            ],
          ),
        ),
      ),
    );
  }
}
