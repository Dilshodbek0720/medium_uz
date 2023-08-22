import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UserModel{
  final int id;
  final String username;
  final String contact;
  final String email;
  final String password;
  final String avatar;
  final String profession;
  final String role;
  final String gender;

  UserModel({
    this.id = 0,
    required this.username,
    required this.contact,
    required this.email,
    required this.password,
    required this.avatar,
    required this.profession,
    required this.role,
    required this.gender,
});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json["password"] as String? ?? "",
      id: json["id"] as int? ?? 0,
      username: json["username"] as String? ?? "",
      email: json["email"] as String? ?? "",
      avatar: json["avatar"] as String? ?? "",
      contact: json["contact"] as String? ?? "",
      gender: json["gender"] as String? ?? "",
      profession: json["profession"] as String? ?? "",
      role: json["role"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "contact": contact,
      "email": email,
      "password": password,
      "avatar": avatar,
      "profession": profession,
      "role": role,
      "gender": gender,
    };
  }

  Future<FormData> getFormData(XFile file) async {
    String fileName = file.path.split('/').last;
    return FormData.fromMap({
      "username": username,
      "contact": contact,
      "email": email,
      "password": password,
      "profession": profession,
      "role": role,
      "gender": gender,
      "avatar": await MultipartFile.fromFile(file.path, filename: fileName),
    });
  }
}