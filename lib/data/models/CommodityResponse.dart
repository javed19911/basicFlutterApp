import 'default_response.dart';
import 'mCommodity.dart';

class CommodityResponse extends DefaultResponse {
  List<mCommodity?>? _commodities;
  bool? _isInternal;

  List<mCommodity?>? get commodities => _commodities;
  bool? get isInternal => _isInternal;

  CommodityResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json["commodities"] != null) {
      _commodities = [];
      json["commodities"].forEach((v) {
        _commodities?.add(mCommodity.fromJson(v));
      });
    }
    _isInternal = json["is_internal"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    if (_commodities != null) {
      map["commodities"] = _commodities?.map((v) => v?.toJson()).toList();
    }
    map["is_internal"] = _isInternal;
    return map;
  }
}
