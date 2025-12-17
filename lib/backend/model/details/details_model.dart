import 'dart:convert';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  final dynamic status;
  final Data data;

  DetailsModel({
    required this.status,
    required this.data,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  final dynamic pageTitle;
  final dynamic image;
  final dynamic link;
  final dynamic name;
  final dynamic title;
  final dynamic description;
  final dynamic key;

  Data({
    required this.pageTitle,
    required this.image,
    required this.link,
    required this.name,
    required this.title,
    required this.description,
    required this.key,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageTitle: json["page_title"] ?? '',
        image: json["image"] ?? '',
        link: json["link"] ?? '',
        name: json["name"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        key: json["key"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "page_title": pageTitle,
        "image": image,
        "link": link,
        "name": name,
        "title": title,
        "description": description,
        "key": key,
      };
}
