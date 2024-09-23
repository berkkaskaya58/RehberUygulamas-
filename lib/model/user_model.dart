
class UsersModelSupport {
  String? url;
  String? text;

  UsersModelSupport({this.url, this.text});

  UsersModelSupport.fromJson(Map<String, dynamic> json) {
    url = json['url']?.toString();
    text = json['text']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['text'] = text;
    return data;
  }
}

class UsersModelData {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UsersModelData({this.id, this.email, this.firstName, this.lastName, this.avatar});

  UsersModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    email = json['email']?.toString();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    avatar = json['avatar']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}

class UsersModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UsersModelData>? data;
  UsersModelSupport? support;

  UsersModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    page = json['page']?.toInt();
    perPage = json['per_page']?.toInt();
    total = json['total']?.toInt();
    totalPages = json['total_pages']?.toInt();

    if (json['data'] != null) {
      final v = json['data'] as List<dynamic>;
      data = v.map((e) => UsersModelData.fromJson(e)).toList();
    }

    support = json['support'] != null ? UsersModelSupport.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;

    if (this.data != null) {
      data['data'] = this.data!.map((e) => e.toJson()).toList();
    }

    if (support != null) {
      data['support'] = support!.toJson();
    }

    return data;
  }
}

// class UserService {
//   final String url = 'https://reqres.in/api/users?page=2';

//   Future<UsersModel?> fetchUsers() async {
//     try {
//       var res = await http.get(Uri.parse(url));
//       if (res.statusCode == 200) {
//         var jsonBody = jsonDecode(res.body);
//         return UsersModel.fromJson(jsonBody);
//       } else {
//         print("İstek başarısız oldu => ${res.statusCode}");
//       }
//     } catch (e) {
//       print("Bir hata oluştu: $e");
//     }
//     return null;
//   }
// }
