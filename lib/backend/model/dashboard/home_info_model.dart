import 'dart:convert';

HomeInfoModel homeInfoModelFromJson(String str) =>
    HomeInfoModel.fromJson(json.decode(str));

String homeInfoModelToJson(HomeInfoModel data) => json.encode(data.toJson());

class HomeInfoModel {
  final Message message;
  final Data data;

  HomeInfoModel({required this.message, required this.data});

  factory HomeInfoModel.fromJson(Map<String, dynamic> json) => HomeInfoModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  final String siteSection;
  final String categorySection;
  final List<Datum> carousalData;
  final List<Datum> adData;
  final List<FootballSectionDatum> footballSectionData;
  final List<SportsCategory> sportsCategory;

  Data({
    required this.siteSection,
    required this.categorySection,
    required this.carousalData,
    required this.adData,
    required this.footballSectionData,
    required this.sportsCategory,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    siteSection: json["site-section"],
    categorySection: json["category-section"],
    carousalData: List<Datum>.from(
      json["carousalData"].map((x) => Datum.fromJson(x)),
    ),
    adData: List<Datum>.from(json["adData"].map((x) => Datum.fromJson(x))),
    footballSectionData: List<FootballSectionDatum>.from(
      json["footballSectionData"].map((x) => FootballSectionDatum.fromJson(x)),
    ),
    sportsCategory: List<SportsCategory>.from(
      json["sportsCategory"].map((x) => SportsCategory.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "site-section": siteSection,
    "category-section": categorySection,
    "carousalData": List<dynamic>.from(carousalData.map((x) => x.toJson())),
    "adData": List<dynamic>.from(adData.map((x) => x.toJson())),
    "footballSectionData": List<dynamic>.from(
      footballSectionData.map((x) => x.toJson()),
    ),
    "sportsCategory": List<dynamic>.from(sportsCategory.map((x) => x.toJson())),
  };
}

class Datum {
  final dynamic id;
  final dynamic sportsId;
  final dynamic link;
  final dynamic image;
  final dynamic buttonName;

  Datum({
    required this.id,
    required this.sportsId,
    required this.link,
    required this.image,
    required this.buttonName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? '',
    sportsId: json["sports_id"] ?? json["sportsId"] ?? json["sport_id"] ?? '',
    link: json["link"] ?? '',
    image: json["image"] ?? '',
    buttonName: json["button_name"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sports_id": sportsId,
    "link": link,
    "image": image,
    "button_name": buttonName,
  };
}

class FootballSectionDatum {
  final dynamic id;
  final dynamic sportsId;
  final dynamic status;
  final dynamic link;
  final dynamic image;
  final dynamic name;
  final dynamic title;

  FootballSectionDatum({
    required this.id,
    required this.sportsId,
    required this.status,
    required this.link,
    required this.image,
    required this.name,
    required this.title,
  });

  factory FootballSectionDatum.fromJson(Map<String, dynamic> json) =>
      FootballSectionDatum(
        id: json["id"] ?? '',
        sportsId:
            json["sports_id"] ?? json["sportsId"] ?? json["sport_id"] ?? '',
        status: json["status"] ?? json["status_value"] ?? false,
        link: json["link"] ?? '',
        image: json["image"] ?? '',
        name: json["name"] ?? '',
        title: json["title"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sports_id": sportsId,
    "status": status,
    "link": link,
    "image": image,
    "name": name,
    "title": title,
  };
}

class SportsCategory {
  final int id;
  final dynamic title;
  final List<Sport> sports;

  SportsCategory({required this.id, required this.title, required this.sports});

  factory SportsCategory.fromJson(Map<String, dynamic> json) => SportsCategory(
    id: json["id"],
    title: json["title"] ?? '',
    sports: List<Sport>.from(json["sports"].map((x) => Sport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sports": List<dynamic>.from(sports.map((x) => x.toJson())),
  };
}

class Sport {
  final dynamic statusValue;
  final int id;
  final dynamic sportsCategoriesId;
  final dynamic image;
  final dynamic link;
  final dynamic status;
  final dynamic name;
  final dynamic title;
  final dynamic description;

  Sport({
    required this.statusValue,
    required this.id,
    required this.sportsCategoriesId,
    required this.image,
    required this.link,
    required this.status,
    required this.name,
    required this.title,
    required this.description,
  });

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
    statusValue: json["status_value"] ?? '',
    id: json["id"],
    sportsCategoriesId: json["sports_categories_id"] ?? '',
    image: json["image"] ?? '',
    link: json["link"] ?? '',
    status: json["status"],
    name: json["name"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "status_value": statusValue,
    "id": id,
    "sports_categories_id": sportsCategoriesId,
    "image": image,
    "link": link,
    "status": status,
    "name": name,
    "title": title,
    "description": description,
  };
}

class Message {
  final List<String> success;

  Message({required this.success});

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(success: List<String>.from(json["success"].map((x) => x)));

  Map<String, dynamic> toJson() => {
    "success": List<dynamic>.from(success.map((x) => x)),
  };
}
