import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/DataManager.dart';
import '../../ui/base/BaseViewModel.dart';

import 'i_sign_up.dart';

class SignUpVM extends BaseViewModel<ISignUp> {
  void createUser(
      BuildContext context, String email, String mobile, String password) {
    mIsLoading = true;
    notifyListeners();
    dataManager.getAccessToken().then((token) => {
          dataManager
              .createUser(token!, email, mobile, password)
              .then((response) {
            if (response.success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "User Created Successfully..",
                ),
                duration: Duration(seconds: 3),
              ));
              navigator?.openLoginActivity();
            } else {
              throw Exception(response.error?.errorMessage);
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
          })
        });
  }
}
