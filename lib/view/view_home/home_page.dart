import 'package:flutter/material.dart';
import 'package:telefon_rehberi/model/user_model.dart';
import 'package:telefon_rehberi/service/user_service.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_image.dart';
import 'package:telefon_rehberi/view/view_add_people/people_add_page.dart';
import 'package:telefon_rehberi/view/view_people_detail/people_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    UserService _service = UserService();
  List<UsersModelData> users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final value = await _service.fetchUsers();
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
        });
      } else {
        print("Kullanıcı verileri bulunamadı.");
      }
    } catch (error) {
      print("Hata: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          builder: (context) => PeopleAdd(),
                        ),
                      );
                    },
                    child: Image.asset(ImagePath.addPeople),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                   
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PeopleDetail(model:users[index],),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${users[index].avatar}'),
                      ),
                      title: Text('${users[index].firstName ?? ""} ${users[index].lastName ?? ""}'),
                      subtitle: Text("${users[index].email}"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



