import 'mVariety.dart';

class mCommodity {
  int _id;
  String _name;
  String _thumbnail;
  List<mVariety> _varieties;
  List<String> _sizes;

  mCommodity();

  int get id => _id;
  String get name => _name;
  String get thumbnail => _thumbnail;
  List<mVariety> get varieties => _varieties;
  List<String> get sizes => _sizes;

  set id(int value) {
    _id = value;
  }

  set name(String value) {
    _name = value;
  }

  set thumbnail(String value) {
    _thumbnail = value;
  }

  set varieties(List<mVariety> value) {
    _varieties = value;
  }

  set sizes(List<String> value) {
    _sizes = value;
  }

  mCommodity.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _thumbnail = json["thumbnail"];

    if (_thumbnail == null || _thumbnail.isEmpty) {
      if (_name.toLowerCase().contains("onion")) {
        _thumbnail =
            "https://pramanapp.s3.ap-south-1.amazonaws.com/images/onions_creation.png";
      } else if (_name.toLowerCase().contains("potato")) {
        _thumbnail =
            "https://pramanapp.s3.ap-south-1.amazonaws.com/images/potato_creation.png";
      } else {
        _thumbnail =
            "https://pramanapp.s3.ap-south-1.amazonaws.com/images/tomato_creation.png";
      }
    }
    _varieties = [];
    if (json["varieties"] != null) {
      json["varieties"].forEach((v) {
        _varieties.add(mVariety.fromJson(v));
      });
    }

    _sizes = json["sizes"] != null ? json["sizes"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["thumbnail"] = _thumbnail;
    map["varieties"] = _varieties;
    map["sizes"] = _sizes;
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return _name.toString();
  }
}
