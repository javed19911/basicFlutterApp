import 'm_group.dart';
import 'm_item.dart';

class CategoryM {
  CategoryM({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.group,
    this.items,
  });

  final int id;
  final String imageUrl;
  final String name;
  final GroupM group;
  List<ItemM>? items;

  factory CategoryM.fromJson(Map<String, dynamic> json) => CategoryM(
        id: json["id"],
        imageUrl: json["image_url"],
        name: json["name"],
        items: json["items"] != null
            ? List<ItemM>.from(json["items"].map((x) => ItemM.fromJson(x)))
            : null,
        group: json["group"] != null
            ? GroupM.fromJson(json["group"])
            : GroupM(id: 0, name: ""),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    if (items != null) {
      data['items'] = this.items!.map((e) => e.toJson()).toList();
    }
    data["group"] = group.toJson();
    return data;
  }
}
