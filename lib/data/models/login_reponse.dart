import 'default_response.dart';
import 'mUser.dart';

class LoginResponse extends DefaultResponse {
  late int _id;
  late String _mobileNumber;
  late String _authenticationToken;
  late String _role;
  late String _email;
  late String _username;
  late String _platformType;

  int get id => _id;
  String get mobileNumber => _mobileNumber;
  String get authenticationToken => _authenticationToken;
  String get role => _role;
  String get email => _email;
  String get username => _username;
  String get platformType => _platformType;

  LoginResponse.fromJson(dynamic json) : super.fromJson(json) {
    _id = json["id"] ?? 0;
    _mobileNumber = json["mobile"] == null ? "" : json["mobile"];
    _authenticationToken = json["auth_key"];
    _role = json["role"] == null ? "" : json["role"];
    _username = json["name"] == null ? "" : json["name"];
    _email = json["email"] == null ? "" : json["email"];
    _platformType = json["platform_type"] == null ? "" : json["platform_type"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();

    map["id"] = _id;
    map["mobile"] = _mobileNumber;
    map["auth_key"] = _authenticationToken;
    map["role"] = _role;
    map["email"] = _email;
    map["name"] = _username;
    map["platform_type"] = _platformType;
    return map;
  }
}
