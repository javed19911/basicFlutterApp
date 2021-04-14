import 'package:intello_track_image_upload_app/data/remote/webservice.dart';

import 'mMapping.dart';

class Gradings {
  int _id;
  String _filename;
  String _path;
  String _message;
  dynamic _status;
  int _lotNum;
  int _analysedCount;
  int _totalCount;
  bool _markedIncorrect;
  bool _machineProcessed;
  String _imageQuality;
  bool _isBad;
  dynamic _badImageType;
  String _time;
  String _date;
  double _resizeFactor;
  int _imageHeight;
  int _imageWidth;
  bool _isOwner;
  List<Mapping> _mapping;

  int get id => _id;
  String get filename => _filename;
  String get path => _path;
  String get message => _message;
  dynamic get status => _status;
  int get lotNum => _lotNum;
  int get analysedCount => _analysedCount;
  int get totalCount => _totalCount;
  bool get markedIncorrect => _markedIncorrect;
  bool get machineProcessed => _machineProcessed;
  String get imageQuality => _imageQuality;
  bool get isBad => _isBad;
  dynamic get badImageType => _badImageType;
  String get time => _time;
  String get date => _date;
  double get resizeFactor => _resizeFactor;
  int get imageHeight => _imageHeight;
  int get imageWidth => _imageWidth;
  bool get isOwner => _isOwner;
  List<Mapping> get mapping => _mapping;

  Gradings();

  Gradings.file(this._filename);

  set id(int value) {
    _id = value;
  }

  set filename(String value) {
    _filename = value;
  }

  set path(String value) {
    _path = value;
  }

  set message(String value) {
    _message = value;
  }

  set status(dynamic value) {
    _status = value;
  }

  set lotNum(int value) {
    _lotNum = value;
  }

  set analysedCount(int value) {
    _analysedCount = value;
  }

  set totalCount(int value) {
    _totalCount = value;
  }

  set markedIncorrect(bool value) {
    _markedIncorrect = value;
  }

  set machineProcessed(bool value) {
    _machineProcessed = value;
  }

  set imageQuality(String value) {
    _imageQuality = value;
  }

  set isBad(bool value) {
    _isBad = value;
  }

  set badImageType(dynamic value) {
    _badImageType = value;
  }

  set time(String value) {
    _time = value;
  }

  set date(String value) {
    _date = value;
  }

  set resizeFactor(double value) {
    _resizeFactor = value;
  }

  set imageHeight(int value) {
    _imageHeight = value;
  }

  set imageWidth(int value) {
    _imageWidth = value;
  }

  set isOwner(bool value) {
    _isOwner = value;
  }

  set mapping(List<Mapping> value) {
    _mapping = value;
  }

  Gradings.fromJson(dynamic json) {
    _id = json["id"];
    _filename = json["filename"];
    if (json["url"].toString().toLowerCase().contains("http")) {
      _path = json["url"];
    } else {
      _path = Webservice.BASE_HOST_URL + json["url"];
    }
    _status = json["status"];
    _message = json["message"];
    _lotNum = json["lot_num"];
    _analysedCount = json["analysed_count"];
    _totalCount = json["total_count"];
    _markedIncorrect = json["marked_incorrect"];
    _machineProcessed = json["processed"] ?? false;
    _imageQuality = json["image_quality"];
    _isBad = json["is_bad"];
    _badImageType = json["bad_image_type"];
    _time = json["time"];
    _date = json["date"];
    _resizeFactor = json['resize_factor'] == null
        ? 0.0
        : double.tryParse(json['resize_factor'].toString()) ?? 0.0;
    _imageHeight = json["height"];
    _imageWidth = json["width"];
    _isOwner = json["is_owner"];
    if (json["mappings"] != null) {
      _mapping = [];
      json["mappings"].forEach((v) {
        _mapping.add(Mapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["filename"] = _filename;
    map["url"] = _path;
    map["message"] = _message;
    map["status"] = _status;
    map["lot_num"] = _lotNum;
    map["analysed_count"] = _analysedCount;
    map["total_count"] = _totalCount;
    map["marked_incorrect"] = _markedIncorrect;
    map["processed"] = _machineProcessed;
    map["image_quality"] = _imageQuality;
    map["is_bad"] = _isBad;
    map["bad_image_type"] = _badImageType;
    map["time"] = _time;
    map["date"] = _date;
    map["resize_factor"] = _resizeFactor;
    map["image_height"] = _imageHeight;
    map["image_width"] = _imageWidth;
    map["is_owner"] = _isOwner;
    if (_mapping != null) {
      map["mappings"] = _mapping.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
