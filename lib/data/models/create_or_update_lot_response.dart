import 'default_response.dart';

class mCreateOrUpdateLot extends DefaultResponse {
  int id;

  mCreateOrUpdateLot.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['id'] = this.id;
    return data;
  }
}
