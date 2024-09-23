import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:telefon_rehberi/model/user_model.dart';

class UserService {
  final  url = 'https://reqres.in/api/users?page=2';

  Future<UsersModel?> fetchUsers() async {
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        var jsonBody = jsonDecode(res.body);
        return UsersModel.fromJson(jsonBody);
      } else {
        log("İstek başarısız oldu => ${res.statusCode}");
       
      }
    } catch (e) {
      log("Bir hata oluştu: $e");
    }
    return null;
  }
}
