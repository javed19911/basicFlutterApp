import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/DataManager.dart';
import '../../ui/base/BaseViewModel.dart';

import 'i_dashboard.dart';

class DashboardVM extends BaseViewModel<IDashboard> {
  void validateUser(BuildContext context, String email, String password) {
    /* if (phone_number.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter valid mobile number...'),
        duration: Duration(seconds: 3),
      ));
      return;
    }
    mIsLoading = true;

    notifyListeners();
    dataManager.validateUser(phone_number).then((response) {
      if (response.success) {
        resent_otp_timer = Timer.periodic(
            Duration(seconds: 1),
            (Timer t) => {
                  resent_otp_count--,
                  if (resent_otp_count <= 0)
                    {resent_otp_text = "Resend OTP", resent_otp_timer.cancel()}
                  else
                    {resent_otp_text = "Resend OTP in $resent_otp_count" + "s"},
                  notifyListeners()
                });
        requestOTP = true;
        phoneNumber = phone_number;
        notifyListeners();
      } else {
        throw Exception(response.error.errorMessage);
      }
    }).catchError((e) {
      print("Got error: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString().replaceAll("Exception: ", ""),
        ),
        duration: Duration(seconds: 3),
      ));
    }).whenComplete(() {
      mIsLoading = false;
      notifyListeners();
    });*/

    // if (navigator != null) {
    //   navigator.openHomeActivity();
    // }
  }
}
