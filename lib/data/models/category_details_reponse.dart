import 'default_response.dart';
import 'mUser.dart';
import 'm_category.dart';
import 'm_item.dart';

class CategoryDetailsResponse extends DefaultResponse {
  List<ItemM>? items;

  CategoryDetailsResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json['items'] != null) {
      items = [];
      json["items"].forEach((v) {
        items!.add(ItemM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    if (items != null) {
      map["items"] = items!.map((category) => category.toJson()).toList();
    }
    return map;
  }
}
