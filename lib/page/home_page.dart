import 'package:flutter/material.dart';
import 'package:telefon_rehberi/data.dart';
import 'package:telefon_rehberi/page/people_add_page.dart';
import 'package:telefon_rehberi/page/people_detail_page.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Names veriler = Names();
   
    return Scaffold(
      backgroundColor: UIColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 47),
          child: Column(
            children: [
              Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 132.8,
                     
                      child: Image.asset(ImagePath.logoIpsum),
                    ),
                    SizedBox(child: GestureDetector(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => PeopleAdd(),));},
                      child: Image.asset(ImagePath.addPeople)),)
                  ],
                  
                ),
              ),
             Container(child:  Expanded(
                child: ListView.builder(
                  itemCount: veriler.isimler.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PeopleDetail(),));
                      },
                      leading:
                          Image.asset('assets/images/${veriler.resimler[index]}.png'),
                      title: Text(veriler.isimler[index]),
                    );
                  },
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
