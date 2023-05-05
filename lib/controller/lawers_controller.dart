import 'package:flutter/material.dart';
import 'package:lawyers_list/model/lawyers/lawyers_model.dart';
import 'package:lawyers_list/services/all_services.dart';

class LawersController with ChangeNotifier {
  List<LawyersModel>? lawersList;
  Future<void> getLawers() async {
    await Allservices().getLawyers().then((value) {
      lawersList = value;
      notifyListeners();
    });
  }
}
