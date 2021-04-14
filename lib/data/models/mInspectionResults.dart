class mInspectionResult {
  int _id;
  String _name;
  String _color;
  double _value;
  String _comments;

  int get id => _id;

  String get name => _name;

  String get color => _color;

  double get value => _value;

  String get comments => _comments;

  mInspectionResult.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    if (json['display_name'] != null && json['display_name'] != "null")
      _name = json['display_name'];
    else
      _name = "";

    if (json['color_code'] != null && json['color_code'] != "null")
      _color = json['color_code'];
    else
      _color = "";

    /* if (json['value'] != null && json['value'] != "null")
      _value = json['value'];
    else
      _value = 0;*/

    _value = json['value'] == null
        ? 0.0
        : double.tryParse(json['value'].toString()) ?? 0.0;

    if (json['comments'] != null && json['comments'] != "null")
      _comments = json['comments'].toString();
    else
      _comments = "--";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['display_name'] = this._name;
    data['color_code'] = this._color;
    data['value'] = this._value;
    data['comments'] = this._comments;
    return data;
  }
}
