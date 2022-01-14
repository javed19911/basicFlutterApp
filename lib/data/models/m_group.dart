class GroupM {
  int _id = 0;
  late String name;

  int get id => _id;

  GroupM({required id, required this.name}) : _id = id;

  GroupM.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this.name;
    return data;
  }
}
