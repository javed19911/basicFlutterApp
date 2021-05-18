import 'mData.dart';

class Filters {
  late String _name;
  late List<Data> _data;

  String get name => _name;
  List<Data> get data => _data;

  Filters({required String name, required List<Data> data}) {
    _name = name;
    _data = data;
  }

  Filters.fromJson(dynamic json) {
    _name = json["name"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
