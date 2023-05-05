import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lawyers_list/core/api_end_points.dart';
import 'package:lawyers_list/core/constants.dart';
import 'package:lawyers_list/model/lawyers/lawyers_model.dart';
import 'package:lawyers_list/model/sign_in/sign_in_req.dart';
import 'package:lawyers_list/model/sign_in/sign_in_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Allservices {
  var dio = Dio();
  // user login
  Future<SignInResModel?> signin(SignInReqModel reqModel) async {
    try {
      Response response = await dio.post(kBaseUrl + ApiEndPoints().signin,
          data: jsonEncode(reqModel.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return SignInResModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }

  //get lawyers
  Future<List<LawyersModel>?> getLawyers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AUTH_TOKEN);
    try {
      Response response = await dio.get(kBaseUrl + ApiEndPoints().getLawyers,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final List<LawyersModel> jsonData = (response.data["data"] as List)
            .map((e) => LawyersModel.fomJson(e))
            .toList();
        return jsonData;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
