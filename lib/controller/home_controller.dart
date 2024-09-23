import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/view/view_people_detail/people_detail_page.dart';

class HomeController extends GetxController {
  // ignore: non_constant_identifier_names
  Widget ContactList() {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final CollectionReference firebaseCollectionRef =
        fireStore.collection('FirebaseCollection');
    //final addPeopleController = Get.find<AddPeopleController>();

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: firebaseCollectionRef.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Bir hata oluştu. Lütfen tekrar deneyin.'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Veri bulunamadı.'));
          }

          List<DocumentSnapshot> list = snapshot.data!.docs;

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              var data = list[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Get.to(() => PeopleDetail(index: index,list: list,));
                },
                child: ListTile(
                  // leading: ClipRRect(
                  //   borderRadius:
                  //       BorderRadius.circular(50), // Köşe yuvarlama değeri
                  //   child: Image.network(
                  //     addPeopleController.uploadFile.value,
                  //     width: 40, // Genişlik
                  //     height:40, // Yükseklik
                  //     fit: BoxFit
                  //         .cover, // Görselin nasıl sığdırılacağını ayarlama
                  //   ),
                  // ),
                  title: Text(data['name'] ?? 'No Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['number'] ?? 'No Number'),
                      Text(data['email'] ?? 'No Email'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await list[index].reference.delete();
                      
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
