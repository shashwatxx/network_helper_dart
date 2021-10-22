// To parse this JSON data, do
//
//     final postsModel = postsModelFromMap(jsonString);

import 'dart:convert';

List<PostsModel> postsModelFromMap(String str) =>
    List<PostsModel>.from(json.decode(str).map((x) => PostsModel.fromMap(x)));

String postsModelToMap(List<PostsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PostsModel {
  PostsModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory PostsModel.fromMap(Map<String, dynamic> json) => PostsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
