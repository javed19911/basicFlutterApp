import 'package:flutter/cupertino.dart';
import 'package:intello_track_image_upload_app/data/AppDataManager.dart';
import 'package:intello_track_image_upload_app/data/DataManager.dart';
/*import 'package:praman_flutter/data/AppDataManager.dart';
import 'package:praman_flutter/data/DataManager.dart';*/

abstract class BaseViewModel<N> extends ChangeNotifier {
  bool _mIsLoading = false;

  N _navigator;

  N get navigator => _navigator;

  set navigator(N value) {
    _navigator = value;
  }

  DataManager _dataManager;

  BaseViewModel() {
    _dataManager = AppDataManager();
  }

  DataManager get dataManager => _dataManager;

  bool get mIsLoading => _mIsLoading;

  set mIsLoading(bool isLoading) {
    _mIsLoading = isLoading;
  }
}
