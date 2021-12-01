import 'dart:ui';

import 'package:basic_flutter_app/data/models/login_reponse.dart';

import 'DataManager.dart';
import 'local/prefs/AppPreferencesHelper.dart';
import 'local/prefs/PreferencesHelper.dart';
import 'models/CommodityResponse.dart';
import 'models/LotResponse.dart';
import 'models/create_or_update_lot_response.dart';
import 'models/default_response.dart';
import 'models/filters_response.dart';
import 'models/otp_reponse.dart';
import 'remote/webservice.dart';

class AppDataManager implements DataManager {
  late Webservice webservice;

  late PreferencesHelper mPreferencesHelper;

  AppDataManager() {
    mPreferencesHelper = AppPreferencesHelper();
    webservice = Webservice();
    /* getHostURL().then((value) {
      if (value != null && value.isNotEmpty && value != "null") {
        Webservice.BASE_HOST_URL = value;
        Webservice.BASE_URL = value + "/api/";
      }
    });*/
  }

  @override
  Future<String?> getHostURL() {
    return mPreferencesHelper.getHostURL();
  }

  @override
  Future<String?> getAccessToken() {
    return mPreferencesHelper.getAccessToken();
  }

  @override
  Future<String?> getCurrentUserEmail() {
    return mPreferencesHelper.getCurrentUserEmail();
  }

  @override
  Future<int?> getCurrentUserId() {
    return mPreferencesHelper.getCurrentUserId();
  }

  @override
  Future<LoggedInMode> getCurrentUserLoggedInMode() {
    return mPreferencesHelper.getCurrentUserLoggedInMode();
  }

  @override
  Future<String?> getCurrentUserName() {
    return mPreferencesHelper.getCurrentUserName();
  }

  @override
  Future<String?> getCurrentUserProfilePicUrl() {
    return mPreferencesHelper.getCurrentUserProfilePicUrl();
  }

  @override
  Future<String?> getFirebaseToken() {
    return mPreferencesHelper.getFirebaseToken();
  }

  @override
  Future<String?> getPassword() {
    return mPreferencesHelper.getPassword();
  }

  @override
  Future<bool?> isRememberCredentials() {
    return mPreferencesHelper.isRememberCredentials();
  }

  @override
  Future<bool> setHostURL(String hostURL) {
    return mPreferencesHelper.setHostURL(hostURL);
  }

  @override
  Future<bool> setAccessToken(String accessToken) {
    return mPreferencesHelper.setAccessToken(accessToken);
  }

  @override
  Future<bool> setCurrentUserEmail(String email) {
    return mPreferencesHelper.setCurrentUserEmail(email);
  }

  @override
  Future<bool> setCurrentUserId(int userId) {
    return mPreferencesHelper.setCurrentUserId(userId);
  }

  @override
  Future<bool> setCurrentUserLoggedInMode(LoggedInMode mode) {
    return mPreferencesHelper.setCurrentUserLoggedInMode(mode);
  }

  @override
  Future<bool> setCurrentUserName(String userName) {
    return mPreferencesHelper.setCurrentUserName(userName);
  }

  @override
  Future<bool> setCurrentUserProfilePicUrl(String profilePicUrl) {
    return mPreferencesHelper.setCurrentUserProfilePicUrl(profilePicUrl);
  }

  @override
  Future<bool> setFirebaseToken(String firebaseToken) {
    return mPreferencesHelper.setFirebaseToken(firebaseToken);
  }

  @override
  Future<bool> setPassword(String password) {
    return mPreferencesHelper.setPassword(password);
  }

  @override
  Future<bool> setRememberCredentials(bool rememberCredentials) {
    return mPreferencesHelper.setRememberCredentials(rememberCredentials);
  }

  @override
  Future<String?> getCurrentUserMobileNo() {
    return mPreferencesHelper.getCurrentUserMobileNo();
  }

  @override
  Future<String?> getCurrentUserRole() {
    return mPreferencesHelper.getCurrentUserRole();
  }

  @override
  Future<bool> setCurrentUserMobileNo(String? mobile_no) {
    return mPreferencesHelper.setCurrentUserMobileNo(mobile_no);
  }

  @override
  Future<bool> setCurrentUserRole(String? role) {
    return mPreferencesHelper.setCurrentUserRole(role);
  }

  @override
  Future<LoggedInPlatform> getCurrentUserLoggedInPlatform() {
    return mPreferencesHelper.getCurrentUserLoggedInPlatform();
  }

  @override
  Future<bool> setCurrentUserLoggedInPlatform(LoggedInPlatform platform) {
    return mPreferencesHelper.setCurrentUserLoggedInPlatform(platform);
  }

  @override
  Future<Locale> getSelectedLanguage() {
    return mPreferencesHelper.getSelectedLanguage();
  }

  @override
  Future<Locale> setLanguage(String languageCode) {
    return mPreferencesHelper.setLanguage(languageCode);
  }

  @override
  Future<LoginResponse> validateUser(String email, String password) {
    return webservice.validateUser(email, password);
  }

  @override
  Future<DefaultResponse> generateOTP(String phone_number) {
    return webservice.generateOTP(phone_number);
  }

  @override
  Future<OTP_Reponse> validateOTP(String phone_number, String OTP) {
    return webservice.validateOTP(phone_number, OTP);
  }

  @override
  Future<LotResponse> getLots(String token, String email, Map filterOption) {
    return webservice.getLots(token, email, filterOption);
  }

  @override
  Future<CommodityResponse> getCommodityList(String token, String email) {
    return webservice.getCommodityList(token, email);
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
      bool is_ai_image) {
    return webservice.uploadLotImage(
        token,
        email,
        temp_id,
        location_type_name,
        job_process_name,
        job_process_id,
        product_id,
        imagePath,
        longitude,
        latitude,
        is_ai_image);
  }
}
