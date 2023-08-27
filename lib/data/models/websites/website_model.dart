import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class WebsiteModel {
  final int id;
  final String name;
  final String link;
  final String contact;
  final String author;
  final String image;
  final String hashtag;
  final String likes;

  WebsiteModel({
    this.id = 0,
    required this.name,
    required this.link,
    required this.contact,
    required this.author,
    required this.image,
    required this.hashtag,
    required this.likes,
  });

  WebsiteModel copyWith({
    int? id,
    String? name,
    String? link,
    String? contact,
    String? author,
    String? image,
    String? hashtag,
    String? likes,
  }) =>
      WebsiteModel(
        id: id ?? this.id,
        name: name ?? this.name,
        link: link ?? this.link,
        contact: contact ?? this.contact,
        author: author ?? this.author,
        image: image ?? this.image,
        hashtag: hashtag ?? this.hashtag,
        likes: likes ?? this.likes,
      );

  factory WebsiteModel.fromJson(Map<String, dynamic> json) {
    return WebsiteModel(
      id: json["id"] as int? ?? 0,
      name: json["name"] as String? ?? "",
      link: json["link"] as String? ?? "",
      contact: json["contact"] as String? ?? "",
      author: json["author"] as String? ?? "",
      image: json["image"] as String? ?? "",
      hashtag: json["hashtag"] as String? ?? "",
      likes: json["likes"] as String? ?? "",
    );}

  Future<FormData> getFormData() async {
    XFile file = XFile(image);
    String fileName = file.path.split('/').last;
    print(file.path);
    print(fileName);
    return FormData.fromMap({
      "name": name,
      "link": link,
      "author": author,
      "contact": contact,
      "hashtag": hashtag,
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
  }

  @override
  String toString() {
    return '''
      name: $name,
      link: $link,
      author: $author,
      contact: $contact,
      hashtag: $hashtag,
      image: $image,
    ''';
  }
}
