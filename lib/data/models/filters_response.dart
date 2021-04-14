import 'default_response.dart';
import 'mFilters.dart';

class GetFilterResponse extends DefaultResponse {
  List<Filters> _filters;

  List<Filters> get filters => _filters;

  GetFilterResponse();

  GetFilterResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json["filters"] != null) {
      _filters = [];
      json["filters"].forEach((v) {
        _filters.add(Filters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    if (_filters != null) {
      map["filters"] = _filters.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Map<String, List> getFilterQuery() {
    var map = Map<String, List>();
    if (_filters != null) {
      _filters.forEach((filter) {
        var query = [];
        filter.data.forEach((data) {
          if (data.selected) {
            query.add(data.tag);
          }
        });
        map[filter.name.toLowerCase()] = query;
      });
    }
    return map;
  }
}
