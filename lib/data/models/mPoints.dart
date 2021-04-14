class Points {
  String _shape;
  double _x2;
  double _y2;
  double _radius;
  double _centerX;
  double _centerY;
  double _endAngle;
  double _majorAxis;
  double _minorAxis;
  double _startAngle;
  bool _fromMachine;
  double _rotationAngle;
  double _rotateByAngle;

  String get shape => _shape;

  set shape(String shape) => _shape = shape;

  double get x2 => _x2;

  set x2(double x2) => _x2 = x2;

  double get y2 => _y2;

  set y2(double y2) => _y2 = y2;

  double get radius => _radius;

  set radius(double radius) => _radius = radius;

  double get centerX => _centerX;

  set centerX(double centerX) => _centerX = centerX;

  double get centerY => _centerY;

  set centerY(double centerY) => _centerY = centerY;

  double get endAngle => _endAngle;

  set endAngle(double endAngle) => _endAngle = endAngle;

  double get majorAxis => _majorAxis;

  set majorAxis(double majorAxis) => _majorAxis = majorAxis;

  double get minorAxis => _minorAxis;

  set minorAxis(double minorAxis) => _minorAxis = minorAxis;

  double get startAngle => _startAngle;

  set startAngle(double startAngle) => _startAngle = startAngle;

  bool get fromMachine => _fromMachine;

  set fromMachine(bool fromMachine) => _fromMachine = fromMachine;

  double get rotationAngle => _rotationAngle;

  set rotationAngle(double rotationAngle) => _rotationAngle = rotationAngle;

  double get rotateByAngle => _rotateByAngle;

  set rotateByAngle(double rotateByAngle) => _rotateByAngle = rotateByAngle;

  Points.fromJson(Map<String, dynamic> json) {
    _shape = json['shape'];
    _x2 = json['x2'] == null
        ? 0.0
        : double.tryParse(json['x2'].toString()) ?? 0.0;
    _y2 = json['y2'] == null
        ? 0.0
        : double.tryParse(json['y2'].toString()) ?? 0.0;
    _radius = json['radius'] == null
        ? 0.0
        : double.tryParse(json['radius'].toString()) ?? 0.0;
    _centerX = json['center_x'] == null
        ? 0.0
        : double.tryParse(json['center_x'].toString()) ?? 0.0;
    _centerY = json['center_y'] == null
        ? 0.0
        : double.tryParse(json['center_y'].toString()) ?? 0.0;
    _endAngle = json['end_angle'] == null
        ? 0.0
        : double.tryParse(json['end_angle'].toString()) ?? 0.0;
    _majorAxis = json['major_axis'] == null
        ? 0.0
        : double.tryParse(json['major_axis'].toString()) ?? 0.0;
    _minorAxis = json['minor_axis'] == null
        ? 0.0
        : double.tryParse(json['minor_axis'].toString()) ?? 0.0;
    _startAngle = json['start_angle'] == null
        ? 0.0
        : double.tryParse(json['start_angle'].toString()) ?? 0.0;
    _fromMachine = json['from_machine'];
    _rotationAngle = json['rotation_angle'] == null
        ? 0.0
        : double.tryParse(json['rotation_angle'].toString()) ?? 0.0;
    _rotateByAngle = json['rotate_by_angle'] == null
        ? 0.0
        : double.tryParse(json['rotate_by_angle'].toString()) ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shape'] = this._shape;
    data['x2'] = this._x2;
    data['y2'] = this._y2;
    data['radius'] = this._radius;
    data['center_x'] = this._centerX;
    data['center_y'] = this._centerY;
    data['end_angle'] = this._endAngle;
    data['major_axis'] = this._majorAxis;
    data['minor_axis'] = this._minorAxis;
    data['start_angle'] = this._startAngle;
    data['from_machine'] = this._fromMachine;
    data['rotation_angle'] = this._rotationAngle;
    data['rotate_by_angle'] = this._rotateByAngle;
    return data;
  }
}
