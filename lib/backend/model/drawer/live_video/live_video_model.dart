import 'dart:convert';

LiveVideoModel liveVideoModelFromJson(String str) =>
    LiveVideoModel.fromJson(json.decode(str));

String liveVideoModelToJson(LiveVideoModel data) => json.encode(data.toJson());

class LiveVideoModel {
  final Message message;
  final Data data;

  LiveVideoModel({
    required this.message,
    required this.data,
  });

  factory LiveVideoModel.fromJson(Map<String, dynamic> json) => LiveVideoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final dynamic liveImagePath;
  final List<LiveDatum> liveData;

  Data({
    required this.liveImagePath,
    required this.liveData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        liveImagePath: json["live_image_path"] ?? '',
        liveData: List<LiveDatum>.from(
            json["liveData"].map((x) => LiveDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "live_image_path": liveImagePath,
        "liveData": List<dynamic>.from(liveData.map((x) => x.toJson())),
      };
}

class LiveDatum {
  final int id;
  final dynamic image;
  final dynamic link;
  final dynamic name;
  final dynamic title;
  final dynamic description;

  LiveDatum({
    required this.id,
    required this.image,
    required this.link,
    required this.name,
    required this.title,
    required this.description,
  });

  factory LiveDatum.fromJson(Map<String, dynamic> json) => LiveDatum(
        id: json["id"],
        image: json["image"] ?? '',
        link: json["link"] ?? '',
        name: json["name"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
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
