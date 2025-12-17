import 'dart:convert';

HighLightModel highLightModelFromJson(String str) =>
    HighLightModel.fromJson(json.decode(str));

String highLightModelToJson(HighLightModel data) => json.encode(data.toJson());

class HighLightModel {
  final Message message;
  final Data data;

  HighLightModel({
    required this.message,
    required this.data,
  });

  factory HighLightModel.fromJson(Map<String, dynamic> json) => HighLightModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final String liveImagePath;
  final List<Highlight> highlight;

  Data({
    required this.liveImagePath,
    required this.highlight,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        liveImagePath: json["live_image_path"],
        highlight: List<Highlight>.from(
            json["highlight"].map((x) => Highlight.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "live_image_path": liveImagePath,
        "highlight": List<dynamic>.from(highlight.map((x) => x.toJson())),
      };
}

class Highlight {
  final int id;
  final String image;
  final String link;
  final String name;
  final String title;
  final String description;

  Highlight({
    required this.id,
    required this.image,
    required this.link,
    required this.name,
    required this.title,
    required this.description,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        id: json["id"],
        image: json["image"],
        link: json["link"],
        name: json["name"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "link": link,
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
