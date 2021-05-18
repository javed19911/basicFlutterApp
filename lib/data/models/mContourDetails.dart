import 'mPoints.dart';

class ContourDetails {
  late String _name;
  late int _value;
  late String _color;
  late int _priority;
  late bool _isDefault;
  late String _contourColor;
  late int _pointsCount;
  late double _percentage;
  late List<Points> _points;

  String get name => _name;
  int get value => _value;
  String get color => _color;
  int get priority => _priority;
  bool get isDefault => _isDefault;
  String get contourColor => _contourColor;
  int get pointsCount => _pointsCount;
  double get percentage => _percentage;
  List<Points> get points => _points;

  ContourDetails(
      {required String name,
      required int value,
      required String color,
      required int priority,
      required String contourColor,
      required int pointsCount,
      required double percentage,
      required List<Points> points}) {
    _name = name;
    _value = value;
    _color = color;
    _priority = priority;
    _contourColor = contourColor;
    _pointsCount = pointsCount;
    _percentage = percentage;
    _points = points;
  }

  ContourDetails.fromJson(dynamic json) {
    _name = json["display_name"];
    _value = json["value"];
    if (json["color"] != null) {
      _color = json["color"];
    } else {
      _color = "#000000";
    }
    _priority = json["priority"];
    _isDefault = json["is_default"];
    _contourColor = json["color_code"] != null ? json["color_code"] : "#ff0000";
    _pointsCount = json["points_count"];
    // _percentage = json["percentage"];
    _percentage = json['percentage'] == null
        ? 0.0
        : double.tryParse(json['percentage'].toString()) ?? 0.0;
    _points = [];
    if (json["contours"] != null) {
      json["contours"].forEach((v) {
        _points.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["value"] = _value;
    map["color"] = _color;
    map["priority"] = _priority;
    map["is_default"] = _isDefault;
    map["color_code"] = _contourColor;
    map["points_count"] = _pointsCount;
    map["percentage"] = _percentage;
    if (_points != null) {
      map["contours"] = _points.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
