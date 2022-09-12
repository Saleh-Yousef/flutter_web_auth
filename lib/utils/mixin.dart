import 'package:aumet_assessment/utils/selected_account_listner.dart';
import 'package:flutter/material.dart';

import '../repo/Dio_service/dio_service.dart';
import 'global_observalable.dart';

mixin Service {
  final HttpRepository? repository = HttpRepository();
}

abstract class Bloc<T extends Object> with ChangeNotifier implements SelectedAccountChangeListner {
  Bloc() {
    GlobalObservable().onAccountChangeStream.stream.listen((event) {
      if (event == GlobalEvent.LOGOUT) {
        clearLoadedData();
      } else {
        onAccountSwitch();
      }
    });
  }
}

abstract class Model<T> {
  Map<String, dynamic> toJson();
  Map<String, dynamic> toDatabaseRow();
  Model();
}
