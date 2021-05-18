class mVariety {
  int _id = 0;
  int? _product_id;
  String _name = "";
  String? _barcode;
  String? _code;
  int? _min_image_count;
  int? _max_image_count;

  mVariety();

  int get id => _id;
  int? get product_id => _product_id;
  String get name => _name;
  String? get barcode => _barcode;
  String? get code => _code;
  int? get min_image_count => _min_image_count;
  int? get max_image_count => _max_image_count;

  set id(int value) {
    _id = value;
  }

  set product_id(int? value) {
    _product_id = value;
  }

  set name(String value) {
    _name = value;
  }

  set barcode(String? value) {
    _barcode = value;
  }

  set code(String? value) {
    _code = value;
  }

  set min_image_count(int? value) {
    _min_image_count = value;
  }

  set max_image_count(int? value) {
    _max_image_count = value;
  }

  mVariety.fromJson(dynamic json) {
    _id = json["id"];
    _product_id = json["product_id"];
    _name = json["name"];
    _barcode = json["barcode"];
    _code = json["code"];
    _min_image_count = json["min_image_count"];
    _max_image_count = json["max_image_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["product_id"] = _product_id;
    map["name"] = _name;
    map["barcode"] = _barcode;
    map["code"] = _code;
    map["min_image_count"] = _min_image_count;
    map["max_image_count"] = _max_image_count;
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return _name.toString();
  }

  bool isEqual(mVariety model) {
    return model == null ? false : this.id == model.id;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => _id;
}
