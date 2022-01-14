import 'package:flutter/cupertino.dart';
import '../../data/AppDataManager.dart';
import '../../data/DataManager.dart';
/*import 'package:praman_flutter/data/AppDataManager.dart';
import 'package:praman_flutter/data/DataManager.dart';*/

abstract class BaseViewModel<N> extends ChangeNotifier {
  bool mIsLoading = false;

  N? navigator;

  late DataManager _dataManager;

  BaseViewModel() {
    _dataManager = AppDataManager();
  }

  DataManager get dataManager => _dataManager;

}
