class mUser {
  int? _id;
  String? _email;
  String? _name;
  String? _authenticationToken;
  String? _phoneNumber;
  String? _role;

  int? get id => _id;

  String? get email => _email;

  String? get name => _name;

  String? get authenticationToken => _authenticationToken;

  String? get phoneNumber => _phoneNumber;

  String? get role => _role;

  mUser.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    if (json['email'] != null && json['email'] != "null")
      _email = json['email'];
    else
      _email = "";

    _authenticationToken = json['auth_key'];

    if (json['mobile'] != null && json['mobile'] != "null")
      _phoneNumber = "${json['mobile']}";
    else
      _phoneNumber = "";

    if (json['role'] != null && json['role'] != "null")
      _role = json['role'];
    else
      _role = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['email'] = this._email;
    data['name'] = this._name;
    data['auth_key'] = this._authenticationToken;
    data['mobile'] = this._phoneNumber;
    data['role'] = this._role;
    return data;
  }
}
