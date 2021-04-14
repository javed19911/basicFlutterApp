import 'package:intello_track_image_upload_app/data/models/CommodityResponse.dart';
import 'package:intello_track_image_upload_app/data/models/LotResponse.dart';
import 'package:intello_track_image_upload_app/data/models/default_response.dart';
import 'package:intello_track_image_upload_app/data/models/otp_reponse.dart';

abstract class ApiHelper {
  Future<DefaultResponse> generateOTP(String phone_number);

  Future<OTP_Reponse> validateOTP(String phone_number, String OTP);

  Future<OTP_Reponse> validateUser(String email, String password);

  Future<LotResponse> getLots(String token, String email, Map filterOption);

  Future<CommodityResponse> getCommodityList(String token, String email);

  // Future<mCreateOrUpdateLot> addAndCreateLot(
  //     int lotId,
  //     int commodityId,
  //     int imageCount,
  //     bool isInternal,
  //     String token,
  //     String quantity,
  //     String price,
  //     String variety,
  //     String size);

  Future<DefaultResponse> uploadLotImage(
      String token,
      String email,
      String temp_id,
      String location_type_name,
      String job_process_name,
      int job_process_id,
      int product_id,
      String imagePath,
      String longitude,
      String latitude,
      bool is_ai_image);
}
