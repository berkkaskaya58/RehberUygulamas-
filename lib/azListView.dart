import 'package:flutter/material.dart';
import 'package:telefon_rehberi/data.dart';
import 'package:telefon_rehberi/page/people_add_page.dart';
import 'package:telefon_rehberi/page/people_detail_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final Names veriler = Names();

  // final List<Widget> _pages = [
  //   // Farklı sayfalar eklenebilir
  //   Center(child: Text('Anasayfa')),
  //   Center(child: Text('Arama')),
  //   Center(child: Text('Profil')),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 47),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 132.8,
                      child: Image.asset("assets/Logo2.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PeopleAdd(),
                          ),
                        );
                      },
                      child: Image.asset("assets/Kisi_logo.png"),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: veriler.isimler.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PeopleDetail(),
                          ),
                        );
                      },
                      leading: Image.asset(
                          'assets/${veriler.resimler[index]}.png'),
                      title: Text(veriler.isimler[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar'ın doğru şekilde yerleştirilmesi
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Seçilen öğeyi günceller
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Arama',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
