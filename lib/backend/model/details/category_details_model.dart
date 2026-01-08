import 'dart:convert';

CategoryDetailsModel categoryDetailsModelFromJson(String str) =>
    CategoryDetailsModel.fromJson(json.decode(str));

String categoryDetailsModelToJson(CategoryDetailsModel data) =>
    json.encode(data.toJson());

class CategoryDetailsModel {
  final Message message;
  final Data data;

  CategoryDetailsModel({
    required this.message,
    required this.data,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) =>
      CategoryDetailsModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final String pageTitle;
  final int id;
  final String image;
  final String link;
  final String name;
  final String title;
  final dynamic type;
  final String description;

  Data({
    required this.pageTitle,
    required this.id,
    required this.image,
    required this.link,
    required this.name,
    required this.title,
    required this.type,
    required this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageTitle: json["page_title"],
        id: json["id"],
        image: json["image"],
        link: json["link"],
        name: json["name"],
        title: json["title"],
        type: json["type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "page_title": pageTitle,
        "id": id,
        "image": image,
        "link": link,
        "name": name,
        "title": title,
        "type": type,
        "description": description,
      };
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
