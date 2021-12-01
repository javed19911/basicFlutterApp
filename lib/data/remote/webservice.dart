import 'dart:convert';
import 'dart:ui';

import 'package:basic_flutter_app/data/models/login_reponse.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import '../../utils/UtilFunctions.dart';
import '../local/prefs/AppPreferencesHelper.dart';
import '../models/CommodityResponse.dart';
import '../models/LotResponse.dart';
import '../models/default_response.dart';
import '../models/otp_reponse.dart';

import 'ApiHelper.dart';

class Webservice implements ApiHelper {
  //staging
  static String BASE_HOST_URL =
      "https://script.google.com/macros/s/AKfycbznmdggaAnP9OjcQQqg65EAAI83-JTWlErJpTgRQs729BgKkVQ0Gj1XLPeUFQ77Uba5/exec";

  //production
  //static final String BASE_HOST_URL = "http://staging.praman.ai" ;
  static String BASE_URL = BASE_HOST_URL + "";

  Future<Map<String, String>> getHeader() async {
    Locale lang = await AppPreferencesHelper().getSelectedLanguage();
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "lang": lang.languageCode
    };
  }

  Webservice();

  Future<bool> isInternet() async {
    if (BASE_HOST_URL.contains("192.168")) {
      return true;
    }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Future<LoginResponse> validateUser(String email, String password) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    int timeZoneOffset = UtilFunctions.getLocalTimezoneOffsetInSeconds();

    Map data = {
      "action": "login",
      "user_name": "$email",
      "password": "$password"
      // "device_token": "",
      // "offset": timeZoneOffset
    };

    String body = json.encode(data);

    final response = await http.get(
        Uri.parse(
            BASE_URL + "?action=login&user_name=$email&password=$password"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });

    // final response = await http.post(
    //     Uri.parse(
    //         "https://script.google.com/macros/s/AKfycbznmdggaAnP9OjcQQqg65EAAI83-JTWlErJpTgRQs729BgKkVQ0Gj1XLPeUFQ77Uba5/exec"),
    //     // headers: {
    //     //   "Accept": "application/json",
    //     //   "Content-Type": "application/json"
    //     // },
    //     body: data);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return LoginResponse.fromJson(body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  @override
  Future<DefaultResponse> generateOTP(String phone_number) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }

    Map data = {
      //'mobile': phone_number,
      'email': phone_number,
      'app_hashcode': "ktxrq+ZgQUQ" //release code
      //'app_hashcode': "bOT/9cpIF79" //javed's staging code
    };

    String body = json.encode(data);

    final response =
        await http.post(Uri.parse("${BASE_URL}v1/users/generate_otp"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Headers': '*'
            },
            body: body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return DefaultResponse.fromJson(body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  @override
  Future<OTP_Reponse> validateOTP(String phone_number, String OTP) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    ;

    Map data = {
      //'mobile': phone_number,
      'email': phone_number,
      'otp': OTP
    };

    String body = json.encode(data);

    final response = await http.post(
        Uri.parse(BASE_URL + "v1/users/login_with_otp"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return OTP_Reponse.fromJson(body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  @override
  Future<LotResponse> getLots(
      String token, String email, Map filterOption) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    ;

    int timeZoneOffset = UtilFunctions.getLocalTimezoneOffsetInSeconds();
    //int currentTimestamp = UtilFunctions.getUnixTimeStamp(new DateTime.now());

    Map data = {
      'token': token,
      'email': email,
      'local_timezone': timeZoneOffset,
      //'date_time': currentTimestamp
      'options': filterOption
    };

    String body = json.encode(data);

    final response = await http.post(
        Uri.parse(BASE_URL + "v2/inspections/index"),
        /*final response = await http.post(
        "http://trade.praman.ai/api/v23/lots/index",*/
        headers: await getHeader(),
        body: body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      //print("body : ${body}");
      return LotResponse.fromJson(body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  @override
  Future<CommodityResponse> getCommodityList(String token, String email) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }

    Map data = {
      'token': token,
      'email': email,
    };

    String body = json.encode(data);

    final response = await http.post(
        Uri.parse(BASE_URL + "v2/inspections/commodities"),
        /* final response = await http.post(
        "http://3.7.230.206:4000/api/pfg_test/inspections/commodities",*/
        headers: await getHeader(),
        body: body);

    if (response.statusCode == 200) {
      final body1 = jsonDecode(response.body);
      return CommodityResponse.fromJson(body1);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  @override
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
      bool is_ai_image) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }

    Map data = {
      "token": token,
      "email": email,
      "temp_id": temp_id,
      "location_type_name": location_type_name,
      "job_process_name": job_process_name,
      "job_process_id": job_process_id,
      "product_id": product_id,
      "image": imagePath,
      "longitude": longitude,
      "latitude": latitude,
      "is_ai_image": is_ai_image,
    };

    String body = json.encode(data);

    final response = await http
        //.post(BASE_URL + "lots/gradings/classify_vegetable", body: body);
        .post(Uri.parse("15.206.220.141:4000/api/v1/inspections/save_image"),
            body: body);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return DefaultResponse.fromJson(jsonBody);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
