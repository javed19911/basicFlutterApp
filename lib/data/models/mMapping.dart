import 'mContourDetails.dart';

class Mapping {
  String _name;
  List<ContourDetails> _contourDetails;

  String get name => _name;
  List<ContourDetails> get contourDetails => _contourDetails;

  Mapping({String name, List<ContourDetails> contourDetails}) {
    _name = name;
    _contourDetails = contourDetails;
  }

  Mapping.fromJson(dynamic json) {
    _name = json["display_name"];
    if (json["data"] != null) {
      _contourDetails = [];
      json["data"].forEach((v) {
        _contourDetails.add(ContourDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["display_name"] = _name;
    if (_contourDetails != null) {
      map["data"] = _contourDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
