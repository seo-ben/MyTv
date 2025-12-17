class RecentViewsModel {
  final Data data;

  RecentViewsModel({
    required this.data,
  });

  factory RecentViewsModel.fromJson(Map<String, dynamic> json) => RecentViewsModel(
    data: Data.fromJson(json["data"]),
  );
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
}

class Datum {
  final String id;
  final String image;
  final String slug;
  // final bool status;
  final String name;
  final String title;
  final String description;

  Datum({
    required this.id,
    required this.image,
    required this.slug,
    // required this.status,
    required this.name,
    required this.title,
    required this.description,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"]?.toString() ?? "",
    image: json["image"] ?? "",
    slug: json["slug"] ?? "",
    // status: json["status"],
    name: json["name"] ?? "",
    title: json["title"] ?? "",
    description: json["description"] ?? "",
  );
}