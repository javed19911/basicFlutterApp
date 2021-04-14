import 'package:intello_track_image_upload_app/data/remote/webservice.dart';

import 'MachineProcessedText.dart';
import 'mCommodity.dart';
import 'mInspectionResults.dart';
import 'mVariety.dart';
import 'mVendor.dart';
import 'mMapping.dart';
import 'mGrading.dart';

class mLot {
  int id;
  String tempId;
  String name;
  String date;
  String time;
  String inspectionBy;
  int analysedCount;
  int totalCount;
  String thumbnail;
  mVariety variety;
  String size = "";
  List<mInspectionResult> inspectionResults;
  bool machineProcessed = false;
  mCommodity commodity;
  mVendor vendor;
  List<Mapping> mapping;
  List<Gradings> gradings = List.empty(growable: true);
  String reportUrl;
  String latitude;
  String longitude;
  int refreshAfter = 0;
  MachineProcessedText machineProcessedText;

  mLot();

  mLot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tempId = json['temp_id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    inspectionBy = json['inspection_by'];
    analysedCount = json['analysed_count'];
    totalCount = json['total_count'];

    if (json["thumbnail"].toString().toLowerCase().contains("http")) {
      thumbnail = json['thumbnail'];
    } else {
      thumbnail = Webservice.BASE_HOST_URL + json['thumbnail'];
    }

    refreshAfter = json['refresh_after'] ?? 0;

    if (json["variety"] != null) {
      variety = mVariety.fromJson(json["variety"]);
    }
    if (json["size"] != null) {
      size = json["size"];
    }
    if (json["inspection_results"] != null) {
      inspectionResults = [];
      json["inspection_results"].forEach((v) {
        inspectionResults.add(mInspectionResult.fromJson(v));
      });
    }
    machineProcessed = json['processed'];

    commodity = json['commodity'] != null
        ? new mCommodity.fromJson(json['commodity'])
        : null;
    vendor =
        json['vendor'] != null ? new mVendor.fromJson(json['vendor']) : null;

    if (json["mappings"] != null) {
      mapping = [];
      json["mappings"].forEach((v) {
        mapping.add(Mapping.fromJson(v));
      });
    }
    if (json["images"] != null) {
      gradings = [];
      json["images"].forEach((v) {
        gradings.add(Gradings.fromJson(v));
      });
    }
    reportUrl = json["report_url"];
    latitude = json['latitude'];
    longitude = json['longitude'];
    machineProcessedText = json['machine_processed_text'] != null
        ? new MachineProcessedText.fromJson(json['machine_processed_text'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['temp_id'] = this.tempId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['time'] = this.time;
    data['inspection_by'] = this.inspectionBy;
    data['total_count'] = this.totalCount;
    data['analysed_count'] = this.analysedCount;
    ;
    data['thumbnail'] = this.thumbnail;

    data["variety"] = variety.toJson();
    data["size"] = size;
    if (inspectionResults != null) {
      data["inspection_results"] =
          inspectionResults.map((v) => v.toJson()).toList();
    }

    data['processed'] = this.machineProcessed;

    if (this.commodity != null) {
      data['commodity'] = this.commodity.toJson();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor.toJson();
    }

    if (mapping != null) {
      data["mappings"] = mapping.map((v) => v.toJson()).toList();
    }
    if (gradings != null) {
      data["images"] = gradings.map((v) => v.toJson()).toList();
    }
    data["report_url"] = reportUrl;
    data["refresh_after"] = refreshAfter;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.machineProcessedText != null) {
      data['machine_processed_text'] = this.machineProcessedText.toJson();
    }
    return data;
  }
}
