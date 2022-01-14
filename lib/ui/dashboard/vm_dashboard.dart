import 'dart:async';

import 'package:basic_flutter_app/data/models/category_reponse.dart';
import 'package:basic_flutter_app/data/models/m_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/DataManager.dart';
import '../../ui/base/BaseViewModel.dart';

import 'i_dashboard.dart';

class DashboardVM extends BaseViewModel<IDashboard> {
  CategoryResponse? categoryResponse;
  GroupM? selectedGroup;
  late String userName;
  late String userEmail;
  late String userPhone;

  DashboardVM() : super() {
    dataManager.getCurrentUserName().then((value) => userName = value!);
    dataManager.getCurrentUserEmail().then((value) => userEmail = value!);
    dataManager.getCurrentUserMobileNo().then((value) => userPhone = value!);
  }

  void setGroup(BuildContext context, GroupM group) {
    if (selectedGroup != group) {
      selectedGroup = group;
      getCategories(context);
    }
  }

  void getCategories(BuildContext context) {
    mIsLoading = true;
    notifyListeners();
    dataManager.getAccessToken().then((token) => {
          dataManager
              .getCategories(token!, group: selectedGroup)
              .then((response) {
            if (response.success) {
              categoryResponse = response;
              if (selectedGroup == null &&
                  response.groups != null &&
                  response.groups!.length > 0) {
                selectedGroup = response.groups!.last;
                // selectedGroup!.name = "Categories";
              }
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

    // if (navigator != null) {
    //   navigator.openHomeActivity();
    // }
  }
}
