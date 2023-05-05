import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lawyers_list/core/constants.dart';
import 'package:lawyers_list/views/auth/login/views/login_page.dart';
import 'package:lawyers_list/views/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenProvider with ChangeNotifier {
  bool? isLoggedIn;
  splashTimer(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AUTH_TOKEN);
    isLoggedIn = token != null;
    Timer(
        const Duration(seconds: 3),
        () => isLoggedIn!
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                )));
  }
}
