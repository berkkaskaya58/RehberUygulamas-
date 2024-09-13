import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:telefon_rehberi/model/user_model.dart';

class UserService {
  final String url = 'https://192.168.12.80/';

  Future<UsersModel?> fetchUsers() async {
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        var jsonBody = jsonDecode(res.body);
        return UsersModel.fromJson(jsonBody);
      } else {
        print("İstek başarısız oldu => ${res.statusCode}");
      }
    } catch (e) {
      print("Bir hata oluştu: $e");
    }
    return null;
  }
}
