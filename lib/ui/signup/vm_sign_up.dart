import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/DataManager.dart';
import '../../ui/base/BaseViewModel.dart';

import 'i_sign_up.dart';

class SignUpVM extends BaseViewModel<ISignUp> {
  void validateUser(BuildContext context, String email, String password) {
    mIsLoading = !mIsLoading;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {
      mIsLoading = false;
      notifyListeners();
      navigator?.openLoginActivity();
    });
  }
}
