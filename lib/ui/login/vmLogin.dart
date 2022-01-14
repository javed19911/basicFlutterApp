import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/DataManager.dart';
import '../../ui/base/BaseViewModel.dart';

import 'iLogin.dart';

class vmLogin extends BaseViewModel<iLogin> {
  late String phoneNumber;

  void checkIfAlreadyLoggedIn() {
    dataManager.isRememberCredentials().then((value) {
      if (value != null && value) {
        navigator?.openHomeActivity();
      }
    });
  }

  void validateUser(BuildContext context, String userName, String password) {
    mIsLoading = true;
    notifyListeners();

    dataManager.validateUser(userName, password).then((response) {
      if (response.success) {
        dataManager.setRememberCredentials(true);
        dataManager.setCurrentUserId(response.user!.id!);
        dataManager.setCurrentUserName(response.user!.name!);
        dataManager.setAccessToken(response.user!.authenticationToken!);
        dataManager
            .setCurrentUserLoggedInMode(LoggedInMode.LOGGED_IN_MODE_SERVER);
        // if (response.user!.platformType.toLowerCase() == "auction") {
        //   dataManager.setCurrentUserLoggedInPlatform(
        //       LoggedInPlatform.LOGGED_IN_PLATFORM_AUCTIONER);
        // } else {
        //   dataManager.setCurrentUserLoggedInPlatform(
        //       LoggedInPlatform.LOGGED_IN_PLATFORM_TRADER);
        // }
        dataManager.setCurrentUserEmail(response.user!.email!);
        dataManager.setCurrentUserMobileNo(response.user?.phoneNumber);
        dataManager.setCurrentUserRole(response.user?.role);

        navigator?.openHomeActivity();
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
    });

    // if (navigator != null) {
    //   navigator.openHomeActivity();
    // }

    // generateOTP(context, email, password);

    // if (userName.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('Please enter valid Username...'),
    //     duration: Duration(seconds: 3),
    //   ));
    // } else if (userName.toLowerCase() == "demo" &&
    //     password.toLowerCase() == "123456") {
    //   mIsLoading = !mIsLoading;
    //   notifyListeners();
    //   Future.delayed(const Duration(seconds: 2), () {
    //     mIsLoading = false;
    //     notifyListeners();
    //     navigator?.openHomeActivity();
    //   });
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('Invalid username or password...'),
    //     duration: Duration(seconds: 3),
    //   ));
    // }
  }

  void generateOTP(BuildContext context, String phone_number, String otp) {
    /* if(!terms_of_use_and_privacy_policy){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please agree to Terms of Use and Privacy Policy'),
        duration: Duration(seconds: 3),
      ));
      return;
    }*/
    if (phone_number.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter valid Username...'),
        duration: Duration(seconds: 3),
      ));
      return;
    }
    phone_number = phone_number + "@intellolabs.com";

    mIsLoading = true;
    notifyListeners();

    dataManager.generateOTP(phone_number).then((response) {
      if (response.success) {
        phoneNumber = phone_number;
        validateOTP(context, otp);
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
    });
  }

  void validateOTP(BuildContext context, String otp) {
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter valid password...'),
        duration: Duration(seconds: 3),
      ));
      return;
    }

    mIsLoading = true;
    notifyListeners();
    dataManager.validateOTP(phoneNumber, otp).then((response) {
      if (response.success) {
        dataManager.setRememberCredentials(true);
        dataManager.setCurrentUserId(response.user!.id!);
        dataManager.setCurrentUserName(response.user!.email!);
        dataManager.setAccessToken(response.user!.authenticationToken!);
        dataManager
            .setCurrentUserLoggedInMode(LoggedInMode.LOGGED_IN_MODE_SERVER);
        // if (response.user!.userType!.toLowerCase() == "auction") {
        //   dataManager.setCurrentUserLoggedInPlatform(
        //       LoggedInPlatform.LOGGED_IN_PLATFORM_AUCTIONER);
        // } else {
        //   dataManager.setCurrentUserLoggedInPlatform(
        //       LoggedInPlatform.LOGGED_IN_PLATFORM_TRADER);
        // }
        dataManager.setCurrentUserEmail(response.user!.email!);
        dataManager.setCurrentUserMobileNo(response.user?.phoneNumber);
        dataManager.setCurrentUserRole(response.user?.role);

        navigator?.openHomeActivity();
      } else {
        throw Exception(response.error?.errorMessage);
      }
    }).catchError((e) {
      print("Got error: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString().replaceAll("Exception: ", "")),
        duration: Duration(seconds: 3),
      ));
    }).whenComplete(() {
      mIsLoading = false;
      notifyListeners();
    });
  }
}
