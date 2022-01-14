import 'package:basic_flutter_app/data/models/m_group.dart';

import 'default_response.dart';
import 'm_category.dart';

class CategoryResponse extends DefaultResponse {
  List<CategoryM>? categories;
  List<GroupM>? groups;

  CategoryResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json['categories'] != null) {
      categories = [];
      json["categories"].forEach((v) {
        categories!.add(CategoryM.fromJson(v));
      });
    }
    if (json['groups'] != null) {
      groups = [];
      json["groups"].forEach((v) {
        groups!.add(GroupM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    if (categories != null) {
      map["categories"] =
          categories!.map((category) => category.toJson()).toList();
    }
    if (groups != null) {
      map["groups"] = groups!.map((group) => group.toJson()).toList();
    }
    return map;
  }
}
