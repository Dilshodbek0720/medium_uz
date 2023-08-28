
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ArticleModel {
  final int artId;
  final String image;
  final String title;
  final String description;
  final String likes;
  final String views;
  final String addDate;
  final String username;
  final String avatar;
  final String profession;
  final int userId;

  ArticleModel({
    required this.profession,
    required this.userId,
    required this.likes,
    required this.artId,
    required this.image,
    required this.description,
    required this.views,
    required this.title,
    required this.avatar,
    required this.addDate,
    required this.username,
  });

  ArticleModel copyWith({
    int? artId,
    int? userId,
    String? profession,
    String? likes,
    String? image,
    String? description,
    String? views,
    String? title,
    String? avatar,
    String? addDate,
    String? username,
  }) =>
      ArticleModel(
        artId: artId ?? this.artId,
        userId: userId ?? this.userId,
        profession: profession ?? this.profession,
        likes: likes ?? this.likes,
        image: image ?? this.image,
        description: description ?? this.description,
        views: views ?? this.views,
        title: title ?? this.title,
        avatar: avatar ?? this.avatar,
        addDate: addDate ?? this.addDate,
        username: username ?? this.username,
      );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      userId: json["user_id"] as int? ?? 0,
      profession: json["profession"] as String? ?? "",
      likes: json["likes"] as String? ?? "",
      artId: json["art_id"] as int? ?? 0,
      image: json["image"] as String? ?? "",
      description: json["description"] as String? ?? "",
      views: json["views"] as String? ?? "",
      title: json["title"] as String? ?? "",
      avatar: json["avatar"] as String? ?? "",
      addDate: json["add_date"] as String? ?? "",
      username: json["username"] as String? ?? "",
    );
  }

  Future<FormData> getFormData() async {
    XFile file = XFile(image);
    String fileName = file.path.split('/').last;
    debugPrint(file.path);
    debugPrint(fileName);
    return FormData.fromMap({
      "title": title,
      "description": description,
      "hashtag": "#hashtag",
      "image": file.path,
    });
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "profession": profession,
      "userId": userId,
      "title": title,
      "description": description,
      "likes": likes,
      "views": views,
      "addDate": addDate,
      "username": username,
      "avatar": avatar,
    };
  }
}