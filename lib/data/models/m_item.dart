import 'package:basic_flutter_app/data/models/m_category.dart';
import 'package:basic_flutter_app/data/models/m_group.dart';

class ItemM {
  ItemM({
    required this.id,
    required this.name,
    required this.group,
    this.category,
    required this.videoUrl,
    required this.sDesc,
    required this.lDesc,
  });

  final int id;
  final String name;
  final GroupM group;
  final CategoryM? category;
  final String videoUrl;
  final String sDesc;
  final String lDesc;

  factory ItemM.fromJson(Map<String, dynamic> json) {
    String videoID = (json["video_url"] as String).split("=")[1];
    return ItemM(
      id: json["id"],
      name: json["name"],
      group: json["group1"] != null && json["group1"] is! int
          ? GroupM.fromJson(json["group"])
          : GroupM(id: -1, name: ""),
      category: json["category1"] != null && json["category1"] is! int
          ? CategoryM.fromJson(json["category"])
          : null,
      videoUrl: videoID,
      sDesc: json["s_desc"],
      lDesc: json["l_desc"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['video_url'] = this.videoUrl;
    data['s_desc'] = this.sDesc;
    data['l_desc'] = this.lDesc;

    data['group'] = this.group.toJson();
    if (category != null) {
      data['category'] = this.category!.toJson();
    }

    return data;
  }
}
