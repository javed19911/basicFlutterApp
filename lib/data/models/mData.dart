class Data {
  late String _name;
  late String _tag;
  late String _selectedImageUrl;
  late String _unselectedImageUrl;
  late bool _selected;
  late bool _multipleSelect;

  String get name => _name;
  String get tag => _tag;
  String get selectedImageUrl => _selectedImageUrl;
  String get unselectedImageUrl => _unselectedImageUrl;
  bool get selected => _selected;
  bool get multipleSelect => _multipleSelect;

  set selected(bool value) => _selected = value;

  Data(
      {required String name,
      required String tag,
      required String selectedImageUrl,
      required String unselectedImageUrl,
      required bool selected,
      required bool multipleSelect}) {
    _name = name;
    _tag = tag;
    _selectedImageUrl = selectedImageUrl;
    _unselectedImageUrl = unselectedImageUrl;
    _selected = selected;
    _multipleSelect = multipleSelect;
  }

  Data.fromJson(dynamic json) {
    _name = json["name"];
    _tag = json["tag"];
    _selectedImageUrl = json["selected_image_url"];
    _unselectedImageUrl = json["unselected_image_url"];
    _selected = json["selected"];
    _multipleSelect = json["multiple_select"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["tag"] = _tag;
    map["selected_image_url"] = _selectedImageUrl;
    map["unselected_image_url"] = _unselectedImageUrl;
    map["selected"] = _selected;
    map["multiple_select"] = _multipleSelect;
    return map;
  }
}
