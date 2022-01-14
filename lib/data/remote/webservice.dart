import 'dart:convert';
import 'dart:ui';

import 'package:basic_flutter_app/data/models/category_details_reponse.dart';
import 'package:basic_flutter_app/data/models/category_reponse.dart';
import 'package:basic_flutter_app/data/models/login_reponse.dart';
import 'package:basic_flutter_app/data/models/m_category.dart';
import 'package:basic_flutter_app/data/models/m_group.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../utils/UtilFunctions.dart';
import '../local/prefs/AppPreferencesHelper.dart';
import '../models/default_response.dart';
import '../models/otp_reponse.dart';

import 'ApiHelper.dart';

class Webservice implements ApiHelper {
  //staging
  static String BASE_HOST_URL =
      "https://script.google.com/macros/s/AKfycbwVTotdOS_TGO9EXF8jaxlk8v0kWYTCz6a_Ma8-y0FljLRiZWnBJoQ5WYSAI-dO05Xv/exec";

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
    // int timeZoneOffset = UtilFunctions.getLocalTimezoneOffsetInSeconds();

    var data = {
      "action": "login",
      "user_name": "$email",
      "password": "$password"
      // "device_token": "",
      // "offset": timeZoneOffset
    };

    var response = await Dio().get(
      BASE_URL,
      queryParameters: data,
    );
    // final response =
    //     await http.post(Uri.parse(BASE_URL), followRedirects: true, body: data);

    if (response.statusCode == 200) {
      print("body : ${response.data}");
      // final body = jsonDecode(response.data);
      // print("body : ${body}");
      return LoginResponse.fromJson(response.data);
    } else {
      print("body : ${response.data}");
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
  Future<CategoryResponse> getCategories(String token, {GroupM? group}) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    var data = {
      "action": "categories",
      'auth_key': token,
      'group_id': group == null ? 0 : group.id,
    };
    var response = await Dio().get(
      BASE_URL,
      queryParameters: data,
    );
    // final response =
    //     await http.post(Uri.parse(BASE_URL), followRedirects: true, body: data);

    if (response.statusCode == 200) {
      print("body : ${response.data}");
      // final body = jsonDecode(response.data);
      // print("body : ${body}");
      return CategoryResponse.fromJson(response.data);
    } else {
      print("body : ${response.data}");
      throw Exception("Unable to perform request!");
    }
  }

  @override
  Future<CategoryDetailsResponse> getCategoryDetail(
      String token, CategoryM category) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    var data = {
      "action": "categoryDetails",
      'auth_key': token,
      'category_id': category.id,
      'group_id': category.group.id,
    };
    var response = await Dio().get(
      BASE_URL,
      queryParameters: data,
    );
    // final response =
    //     await http.post(Uri.parse(BASE_URL), followRedirects: true, body: data);

    if (response.statusCode == 200) {
      print("body : ${response.data}");
      // final body = jsonDecode(response.data);
      // print("body : ${body}");
      return CategoryDetailsResponse.fromJson(response.data);
    } else {
      print("body : ${response.data}");
      throw Exception("Unable to perform request!");
    }
  }

  @override
  Future<LoginResponse> createUser(
      String token, String email, String mobile, String password) async {
    if (!await isInternet()) {
      throw Exception("Check your Internet connection");
    }
    var data = {
      "action": "create_user",
      'auth_key': token,
      'id': 0,
      'name': email.split("@")[0],
      'email': email,
      'mobile': mobile,
      'password': password,
    };
    var response = await Dio().get(
      BASE_URL,
      queryParameters: data,
    );
    // final response =
    //     await http.post(Uri.parse(BASE_URL), followRedirects: true, body: data);

    if (response.statusCode == 200) {
      print("body : ${response.data}");
      // final body = jsonDecode(response.data);
      // print("body : ${body}");
      return LoginResponse.fromJson(response.data);
    } else {
      print("body : ${response.data}");
      throw Exception("Unable to perform request!");
    }
  }
}
