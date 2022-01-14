import 'package:basic_flutter_app/data/models/category_details_reponse.dart';
import 'package:basic_flutter_app/data/models/category_reponse.dart';
import 'package:basic_flutter_app/data/models/login_reponse.dart';
import 'package:basic_flutter_app/data/models/m_category.dart';
import 'package:basic_flutter_app/data/models/m_group.dart';

import '../models/default_response.dart';
import '../models/otp_reponse.dart';

abstract class ApiHelper {
  Future<DefaultResponse> generateOTP(String phoneNumber);

  Future<OTP_Reponse> validateOTP(String phoneNumber, String otp);

  Future<LoginResponse> validateUser(String email, String password);

  Future<LoginResponse> createUser(
      String token, String email, String mobile, String password);

  Future<CategoryResponse> getCategories(String token, {GroupM? group});

  Future<CategoryDetailsResponse> getCategoryDetail(
      String token, CategoryM category);
}
