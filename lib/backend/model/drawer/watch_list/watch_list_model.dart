import 'dart:convert';

WatchListModel watchListModelFromJson(String str) =>
    WatchListModel.fromJson(json.decode(str));

String watchListModelToJson(WatchListModel data) => json.encode(data.toJson());

class WatchListModel {
  final Message message;
  final Data data;

  WatchListModel({
    required this.message,
    required this.data,
  });

  factory WatchListModel.fromJson(Map<String, dynamic> json) => WatchListModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final String categorySection;
  final List<Datum> data;

  Data({
    required this.categorySection,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categorySection: json["category-section"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category-section": categorySection,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final String image;

  final String name;
  final String title;
  final String description;

  Datum({
    required this.id,
    required this.image,
    required this.name,
    required this.title,
    required this.description,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "title": title,
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
