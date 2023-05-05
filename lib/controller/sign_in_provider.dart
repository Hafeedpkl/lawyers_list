import 'package:flutter/material.dart';
import 'package:lawyers_list/core/constants.dart';
import 'package:lawyers_list/model/sign_in/sign_in_req.dart';
import 'package:lawyers_list/services/all_services.dart';
import 'package:lawyers_list/views/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider with ChangeNotifier {
  final phoneConroller = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isNotUser = false;
  Future<void> signIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    notifyListeners();
    final phone = phoneConroller.text.trim();
    final password = passwordController.text.trim();
    final reqModel = SignInReqModel(phone: phone, password: password);
    await Allservices().signin(reqModel).then((value) {
      if (value?.token != null) {
        prefs.setString(AUTH_TOKEN, value!.token);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      }
    });
    isLoading = false;
    notifyListeners();
    phoneConroller.clear();
    passwordController.clear();
  }
}
