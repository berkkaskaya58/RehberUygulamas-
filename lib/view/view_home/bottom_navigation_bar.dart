import 'package:flutter/material.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/view/view_home/home_page.dart';
import 'package:telefon_rehberi/view/view_add_people/last_wanted_page.dart';
import 'package:telefon_rehberi/view/view_quick_calls/quick_calls_page.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_icons.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 2;

  // Her sekme için içerik
  final List<Widget> _pages = [
    quickCalls(), // İlk harfi büyük yapıldı
    lastWantedPage(),
     HomePage(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 5;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Stack(
        children: [
          Container(
            child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: _currentIndex,
              onTap: (value) {
                setState(() {
                  _currentIndex = value; // Seçilen sekmeyi günceller
                });
              },
              selectedItemColor:
                  UIColors.selectedBottomBarIcon, // Seçili öğe rengi
              unselectedItemColor: UIColors.unSelectedBottomBarIcon,
              items: [
                const BottomNavigationBarItem(
                  
                  label: LocaleKeys.quickSearch,
                  icon: ImageIcon(AssetImage(IconPath.starBottom)),
                ),
                const BottomNavigationBarItem(
                  label: LocaleKeys.lastCalls,
                  icon: ImageIcon(AssetImage(IconPath.lastCalls)),
                ),
                BottomNavigationBarItem(
                  backgroundColor: UIColors.white,
                  label: LocaleKeys.peoples,
                  icon: const ImageIcon(AssetImage(IconPath.peoples)),
                ),
                const BottomNavigationBarItem(
                  label: LocaleKeys.keyboard,
                  icon: ImageIcon(AssetImage(IconPath.keyboard)),
                ),
                const BottomNavigationBarItem(
                  label: LocaleKeys.voiceMessage,
                  icon: ImageIcon(AssetImage(IconPath.voiceMessage)),
                ),
              ],
            ),
          ),
          // Positioned(
          //   left: itemWidth * _currentIndex,
          //   child: Container(
          //     width: itemWidth,
          //     height: 2.5, // Çizginin kalınlığı
          //     color: UIColors.selectedBottomBarIcon, // Çizginin rengi
          //   ),
          // ),
        ],
      ),
    );
  }
}
