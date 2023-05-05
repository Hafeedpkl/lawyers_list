import 'package:flutter/material.dart';

class BottomNavController with ChangeNotifier {
  int currentIndex = 0;
  bottomChanger(value) {
    currentIndex = value;
    notifyListeners();
  }
}
