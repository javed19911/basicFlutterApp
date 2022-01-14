import 'dart:async';

import 'package:basic_flutter_app/data/models/category_reponse.dart';
import 'package:basic_flutter_app/data/models/m_category.dart';
import 'package:basic_flutter_app/data/models/m_group.dart';
import 'package:flutter/material.dart';
import '../../data/DataManager.dart';
import '../../ui/base/BaseViewModel.dart';

import 'i_details.dart';

class DetailsVM extends BaseViewModel<IDetails> {
  CategoryM category;

  DetailsVM(this.category);

  void getCategoryDetails(BuildContext context) {
    mIsLoading = true;
    notifyListeners();
    dataManager.getAccessToken().then((token) => {
          dataManager.getCategoryDetail(token!, category).then((response) {
            if (response.success) {
              category.items = response.items;
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
