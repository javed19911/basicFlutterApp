import 'default_response.dart';
import 'mLot.dart';

class LotResponse extends DefaultResponse {
  List<mLot> lots = List.empty(growable: true);
  /*int version;
  bool forceUpdate;
  List<mVideo> video = List.empty(growable: true);
  int fullSizeImageCount;
  int maxQuantity;
  int maxPrice;
  bool pramanTermsAccepted = false;
  bool bannerEnabled = false;
  mBannerDetails bannerDetails;
  bool displayReferButton = false;
  bool displayText = false;
  bool referralEnabled = false;*/

  LotResponse();

  LotResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['inspections'] != null) {
      lots = new List<mLot>.empty(growable: true);
      json['inspections'].forEach((v) {
        lots.add(new mLot.fromJson(v));
      });
    }
    /* version = json['version'];
    forceUpdate = json['force_update'];
    if (json['video'] != null) {
      video = new List<mVideo>.empty(growable: true);
      json['video'].forEach((v) {
        video.add(new mVideo.fromJson(v));
      });
    }
    fullSizeImageCount = json['full_size_image_count'];
    maxQuantity = json['max_quantity'];
    maxPrice = json['max_price'];
    pramanTermsAccepted = json['praman_terms_accepted'];
    bannerEnabled = json['banner_enabled'];
    bannerDetails = json['banner_details'] != null
        ? new mBannerDetails.fromJson(json['banner_details'])
        : null;
    displayReferButton = json['display_refer_button'];
    displayText = json['display_text'];
    referralEnabled = json['referral_enabled'];*/
  }

  Map<String, dynamic> toJson() {
    var data = super.toJson();
    if (this.lots != null) {
      data['inspections'] = this.lots.map((v) => v.toJson()).toList();
    }
    /*data['version'] = this.version;
    data['force_update'] = this.forceUpdate;
    if (this.video != null) {
      data['video'] = this.video.map((v) => v.toJson()).toList();
    }
    data['full_size_image_count'] = this.fullSizeImageCount;
    data['max_quantity'] = this.maxQuantity;
    data['max_price'] = this.maxPrice;
    data['praman_terms_accepted'] = this.pramanTermsAccepted;
    data['banner_enabled'] = this.bannerEnabled;
    if (this.bannerDetails != null) {
      data['banner_details'] = this.bannerDetails.toJson();
    }
    data['display_refer_button'] = this.displayReferButton;
    data['display_text'] = this.displayText;
    data['referral_enabled'] = this.referralEnabled;*/
    return data;
  }
}
